#!/bin/bash
#######################################################################
#
#         A shell script for gathering system information             #
#         Hardware Information for Linux Server                       #
#         Author:   Imran Hasan                                        #
#         Email:    imranhasan1846bd@gmail.com                         #
#         LinkedIn: https://www.linkedin.com/in/imran-hasan-5a4777191/ #
#######################################################################

# Check if the current user is root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo -e "This looks like a 'non-root' user.\nPlease switch to 'root' and run the script again."
    exit 1
fi

# Gather system-related information
echo -e "===== SYSTEM and HARDWARE INFO ====="
freemem=$(free -m | awk 'NR==2 {print $4 " MB"}')
ramspeed=$(dmidecode --type 17 | grep Speed | head -1 | sed 's/^[[:space:]]*//')
ramtype=$(dmidecode --type 17 | grep Type: | head -1 | sed 's/^[[:space:]]*//' | awk '{print $2}')
cpumodel=$(lscpu | grep 'Model name:' | cut -d: -f2 | sed 's/^[[:space:]]*//')
cpunums=$(grep -c '^processor' /proc/cpuinfo)
kernel=$(uname -r)
osinfo=$(cat /etc/redhat-release)
publicip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
privateip=$(ip -4 addr | grep inet | awk '{print $2}' | cut -d/ -f1)

# Display the gathered info on the terminal
echo -e "\n1. OS version: $osinfo"
echo -e "2. Kernel Info: $kernel"
echo -e "3. Free Memory: $freemem"
echo -e "4. RAM Speed: $ramspeed"
echo -e "5. RAM Type: $ramtype"
echo -e "6. Number of Processors: $cpunums"
echo -e "7. CPU Model: $cpumodel"
echo -e "8. Current Disk Usage:"
df -h | awk 'NR>1 {print $4 " free on " $1}' 2>/dev/null
echo -e "9. Private IPs:\n$privateip"
echo -e "10. Public IP:\n$publicip"
