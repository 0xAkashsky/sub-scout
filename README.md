<h1 align="center">
  <img src="https://github.com/0xAkashsky/sub-scout/raw/main/sub-scout-logo1.png" alt="httpx" width="400px"></a>
  <br>
</h1>

# sub-scout

A simple bash script to automate your inital recon and extend your attack surface using popular tools made by infosec community.

<h1 align="center">
  <img src="https://raw.githubusercontent.com/0xAkashsky/sub-scout/main/carbon.png?token=GHSAT0AAAAAAB43VXHFR3OHH6X7GZQDRBFGY5UIVXQ" alt="httpx" width="700px"></a>
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
