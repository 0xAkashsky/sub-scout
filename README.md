<h1 align="center">
  <img src="https://github.com/0xAkashsky/sub-scout/blob/main/static/sub-scout-logo1.png" alt="sub-scout" width="400px"></a>
  <br>
</h1>

A simple bash script to automate your inital recon and extend your attack surface using popular tools made by infosec community.

<h1 align="center">
  <img src="https://github.com/0xAkashsky/sub-scout/blob/main/static/carbon.png" alt="sub-scout" width="700px"></a>
  <br>
</h1>

# Features

 - Sub-scout generate keywords from known subdomain file 
 - Makes its kind of own permutations list according to scope
 - Parses permutations list to regulator to make rules
 - builds final permutation list according to the rules using regulator
 - Resolves permutation subdomain list using PureDns
 - Parses PureDns resolved domain to httpx for http and https probing
 - Runs Aquatone on httpx results.
 - Runs Wayback on resolved domains.
 - Runs Katana on resolved domains.
 - Collect Javascript files by Combining wayback and katana output
 - Check live Javascript files using httpx

# Prerequisite
 - Go [https://go.dev/doc/install]
 - Regulator [https://github.com/cramppet/regulator]
 - PureDns   [https://github.com/d3mondev/puredns]
 - httpx     [https://github.com/projectdiscovery/httpx]
 - Aquatone  [https://github.com/michenriksen/aquatone]
 - Waybackurls [https://github.com/tomnomnom/waybackurls]
 - Katana    [https://github.com/projectdiscovery/katana]
 - MassDns   [https://github.com/blechschmidt/massdns]

Sub-scout does not installs these tools automatically. Manually install all tools and make sure they are available in '/usr/bin'

# How to Run
```
Just Download the bash file 'sub-scout.sh' in Regulator folder.

Give permission '$ chmod +x sub-scout.sh'

Run using 'bash sub-scout.sh known_subdomain_list.txt scope.txt /output_directory/'
```

# Parameters

known_subdomain_list.txt = Know Subdomain list path that you got form subdomain enumeration tools like 'Amass' 'Subfinder'

scope.txt = Enter the in-scope domains file path. like for yahoo program 'yahoo.com' 'aol.com' in a text file.
<h1 align="left">
  <img src="https://github.com/0xAkashsky/sub-scout/blob/main/static/scope-example.png" alt="sub-scout" width="400px"></a>
  <br>
</h1>

/output-directory/ = Enter the directory path you want to save all outputs too. (Ouput Directory should be created Already) 

Note: Filenames does not need to be 'scope.txt' or  'known_subdomain_list.txt' it can be anything just write the correct path of the files in parameters.

# Workflow
<h1 align="left">
  <img src="https://github.com/0xAkashsky/sub-scout/raw/main/static/workflow.jpg" alt="sub-scout" width="600px"></a>
  <br>
</h1>

# Personal Note

I am not a programmer so there could be thousand different ways to do this proccess in more optimize and better way. I made this bash script to automate regulator tool according to scope from my recon purpose. regulator is a great tool to make permutation subdomain list and fast than altdns. 

Credits to all infosec tools mentioned above in Prerequisite section.
