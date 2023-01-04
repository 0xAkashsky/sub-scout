#!/bin/bash


# Collecting parameters

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Tip: You can also provide parameters"
	read -p "Enter subdomain file: " subdomain_list
	read -p "Enter scope file: " scope_list
	read -p "Provide output directory name: " main_dir
else
	subdomain_list="$1"
	scope_list="$2"
	main_dir="$3"
fi

echo "
 __         _       __                     _   
/ _\ _   _ | |__   / _\  ___  ___   _   _ | |_ 
\ \ | | | || '_ \  \ \  / __|/ _ \ | | | || __|   
_\ \| |_| || |_) | _\ \| (__| (_) || |_| || |_ 
\__/ \__,_||_.__/  \__/ \___|\___/  \__,_| \__|
                                           
                                           v1.0    
                                               "

# building required directories

seprator_dir="$main_dir/seprator"
rule_dir="$main_dir/rules"
permutation_dir="$main_dir/permutation"
lives_dir="$main_dir/live_domain"
aquatone_dir="$main_dir/aquatone_output"
wayback_dir="$main_dir/wayback"
js_dir="$main_dir/javascript"

if [ ! -d "$seprator_dir" ] || [ ! -d "$rule_dir" ] || [ ! -d "$permutation_dir" ] || [ ! -d "$lives_dir" ] || [ ! -d "$aquatone_dir" ] || [ ! -d "$wayback_dir" ] || [ ! -d "$js_dir" ]; then
	
	if [ ! -d "$seprator_dir" ]; then
    		mkdir "$seprator_dir"
  	fi
  	if [ ! -d "$rule_dir" ]; then
	    	mkdir "$rule_dir"
  	fi
	if [ ! -d "$permutation_dir" ]; then
    		mkdir "$permutation_dir"
  	fi
  	if [ ! -d "$lives_dir" ]; then
    		mkdir "$lives_dir"
  	fi
  	if [ ! -d "$aquatone_dir" ]; then
    		mkdir "$aquatone_dir"
  	fi
  	if [ ! -d "$wayback_dir" ]; then
    		mkdir "$wayback_dir"
  	fi
  	if [ ! -d "$js_dir" ]; then
    		mkdir "$js_dir"
  	fi	
fi

#time tracker
time=$(date +%T)


# building subkey file
echo
echo -e "[$time] \033[32mGenerating Subkey File\033[0m"
scope=()
while IFS= read -r line; do
  scope+=("$line")
done < "$scope_list"
for i in "${scope[@]}"; do
  sed -i "s/$i//g" "$subdomain_list"
done
time=$(date +%T)
echo -e "[$time] \033[34mSuccess !\033[0m"


# building seprator file
echo
time=$(date +%T)
echo -e "[$time] \033[32mGenerating Seprator file from scope\033[0m"
suffixes=($(cat $scope_list))
for suffix in "${suffixes[@]}"; do
  subdomain_content=($(cat $subdomain_list))
  for contents in "${subdomain_content[@]}"; do
    new_contents="$contents$suffix"
    echo "$new_contents" >> "$seprator_dir/$suffix"
  done
done
time=$(date +%T)
echo -e "[$time] \033[34mSuccess !\033[0m"

# Building Rules
echo
time=$(date +%T)
echo -e "[$time] \033[32mBuilding Rules using regulator\033[0m"
seprator_file_list=$(ls -1p "$seprator_dir")
IFS=$'\n' read -r -d '' -a seprator_file_array <<< "$seprator_file_list"
for seprator_file_name in "${seprator_file_array[@]}"; do
  base_name=${seprator_file_name}
  sub_remove=${seprator_file_name%.sub}
  python3 main.py $base_name $seprator_dir/$base_name $rule_dir/$sub_remove
   printf "Processing... ${loading_characters[${#loading_characters[@]}]} \r"
done
time=$(date +%T)
echo -e "[$time] \033[34mSuccess !\033[0m"

# building permutations
echo
time=$(date +%T)
echo -e "[$time] \033[32mGenerating permutations using regulator\033[0m"
rules_file_list=$(ls -1p "$rule_dir")
IFS=$'\n' read -r -d '' -a rules_file_array <<< "$rules_file_list"
for rules_file_name in "${rules_file_array[@]}"; do
   rules_name=${rules_file_name}
   ./make_brute_list.sh $rule_dir/$rules_name $permutation_dir/$rules_name
done
time=$(date +%T)
echo -e "[$time] \033[34mSuccess !\033[0m"


# Dwnloding DNS resolver list from . You can also provide your own DNS resolver list you dont want to download from public repo for ssecurity reason"
# To provide you own dns resolver list save your reslover list with name 'resolver.txt' in output directory prior to running this script.
echo
echo -e "[$time] \033[32mDownloding DNS resolver file\033[0m"
if [ ! -f "$main_dir/resolvers.txt" ]; then
	curl https://raw.githubusercontent.com/0xAkashsky/sub-scout/main/resolvers.txt > $main_dir/resolvers.txt
fi

echo

# Running Resolver [PureDns]
echo
time=$(date +%T)
echo -e "[$time] \033[32mResolving Subdomains using PureDns\033[0m"
permutation_file_list=$(ls -1p "$permutation_dir")
IFS=$'\n' read -r -d '' -a permutation_file_array <<< "$permutation_file_list"
for permutation_file_name in "${permutation_file_array[@]}";do
   permutation_name=${permutation_file_name}
   puredns resolve $permutation_dir/$permutation_name -r $main_dir/resolvers.txt --quiet --bin massdns > $lives_dir/$permutation_name.live
done
time=$(date +%T)
echo -e "[$time] \033[34mSuccess !\033[0m"


# Running resolver [httpx resolver]
echo
time=$(date +%T)
echo -e "[$time] \033[32mStarting Probe for live http and https server using httpx\033[0m"
httpx_file_list=$(ls -1p "$lives_dir")
IFS=$'\n' read -r -d '' -a httpx_file_array <<< "$httpx_file_list"
for httpx_file_name in "${httpx_file_array[@]}";do
   httpx_name=${httpx_file_name}
   cat $lives_dir/*.live | httpx -silent > $lives_dir/subdomains_resolved_httpx.txt
done
time=$(date +%T)
echo -e "[$time] \033[34mSuccess !\033[0m"


# Running  aquatone
time=$(date +%T)
echo
echo -e "[$time] \033[32mRunning Aqauatone\033[0m"
cat $lives_dir/subdomains_resolved_httpx.txt | sort -u > $lives_dir/aquatone_process_domains.txt
cat $lives_dir/aquatone_process_domains.txt | aquatone -silent -out $aquatone_dir
time=$(date +%T)
echo -e "[$time] \033[34mSuccess !\033[0m"

# running wayback
time=$(date +%T)
echo
echo -e "[$time] \033[32mRunning Wayback\033[0m"
for wayback in "${suffixes[@]}"; do
	echo "$wayback" | waybackurls | sort -u >> $wayback_dir/wayback_output.txt
done
time=$(date +%T)
echo -e "[$time] \033[34mSuccess !\033[0m"

# Collecting possible js file wayback + katana 
time=$(date +%T)
echo
echo -e "[$time] \033[32mCollecting JS files\033[0m"
katana -list $lives_dir/*.live -fs dn -silent | grep .js >> $js_dir/unchecked_js_file
cat $wayback_dir/wayback_output.txt | grep .js$ >> $js_dir/unchecked_js_file
uncheck_js="$js_dir/unchecked_js_file"
time=$(date +%T)
echo -e "[$time] \033[32mChecking live JS files\033[0m"
cat $uncheck_js | httpx -silent -fc 500,404 | sort -u >> $js_dir/live_js_file.txt
time=$(date +%T)
echo -e "[$time] \033[34mSuccess !\033[0m"

#Removing unwanted directories
rm -r $rule_dir
rm -r $permutation_dir
rm -r $seprator_dir

echo
time=$(date +%T)
echo -e "[$time] \033[34mAll tasks Finshed !\033[0m"
