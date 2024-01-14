#!/bin/bash

output_figlet=$(figlet -c Script  Written by Dada)
echo "\033[0;032m ${output_figlet}"
echo "#################################################################"
echo "############ THIS IS THE SCRIPT OF RECON AUTOMATION #############"
echo "#################################################################"

read -p "Enter your IP or domain name: " IP
echo "You are assign domain or IP is: " ${IP}

echo "\033[0;31m We are running subfinder on " ${IP}
subfinder -d  ${IP} > subfinder_${IP}.txt

echo -e "\033[0;32m We are working on  Gau on" ${IP}
gau ${IP} > gau_${IP}.txt

echo "\033[0;32m We are working on  AssetFinder on" ${IP}
assetfinder ${IP} > assetfinder_${IP}.txt

echo  "\033[0;32m We are working on waybackurls on" ${IP}
waybackurls ${IP} > waybackurls_${IP}.txt
echo  "\033[0;32m We are working on dirsearch on" ${IP}
dirsearch -u ${IP} -e* --format simple
echo "Results of ${IP} check on the reports directory"

echo "\033[0;33m We are working on  sublister on" ${IP}
sublist3r -d ${IP} -v -t 100 -o sublist3r_${IP}.txt

echo "\033[0;33m We are working on  sublisterV2 on" ${IP}
sublist3rV2.py -d ${IP} -v -t 100 -o sublist3rV2_${IP}.txt

echo "\033[0;33m We are working on knockpy on" ${IP}
knockpy ${IP} -o .

echo "\033[0;31m  If you want to knockpy result in csv use command knockpy --csv filename.json "
echo "\033[0;32m more about knockpy click https://reconshell.com/knock-subdomain-scan/"


echo "Shorting of the sudomains"
sort subfinder_${IP}.txt gau_${IP}.txt assetfinder_${IP}.txt waybackurls_${IP}.txt  sublist3r_${IP}.txt sublist3rV2_${IP}.txt > sort_domain_${IP}.txt

cat sort_domain_${IP}.txt | httpx -mc 404 | tee subdomain_404_${IP}.txt
cat sort_domain_${IP}.txt | httpx -mc 403 | tee subdomain_403_${IP}.txt
cat sort_domain_${IP}.txt | httpx -mc 401 | tee subdomain_401_${IP}.txt
cat sort_domain_${IP}.txt | httpx -mc 200 | tee subdomain_200_${IP}.txt



cat sort_domain_${IP}.txt | waybackurls | tee sort_waybackdomain_${IP}.txt

cat sort_domain_${IP}.txt | waybackurls | httpx -mc 200 |tee wayback_200_sort_${IP}.txt

#echo  "\033[0;32m We are working on amass on" ${IP}
#amass enum -brute -active -passive -d ${IP} > amass_${IP}.txt
f=$(figlet -c Weldone Dada ! Thanku)
echo "\033[0;32m ${f}" 
