#!/bin/bash
# credits by @xtdevs

URL="https://private-akeno.randydev.my.id/blacklist/list-ip/"

curl -s "$URL" | jq -r '.blacklisted_ips[]' > blocked.ip.list

if [[ ! -s blocked.ip.list ]]; then
  echo "No blacklisted IPs found or failed to fetch data."
  exit 1
fi

while IFS= read -r block
do 
   sudo ufw insert 1 deny from "$block" 
   echo "Blocked IP: $block"
done < "blocked.ip.list"

sudo ufw reload

echo "All blacklisted IPs have been processed."
