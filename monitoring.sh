#!/bin/bash

Architecture=$(uname -a)
CPU_physical=$(cat /proc/cpuinfo | grep 'physical id' | uniq | wc -l)
vCPU=$(cat /proc/cpuinfo | grep '^processor' | uniq | wc -l)
Memory_Usage=$(free -m | awk '/Mem/ {printf("%s/%sMB (%.2f%%)  \n", $3, $2, $3*100/$2)}')
Disk_Usage=$(df -Bg | grep "^/dev" | grep -v "/boot" | awk '{a+=$2} {b+=$3} END {printf "%d/%dGb (%d%%)\n", b, a, b*100/a}')
CPU_load=$(cat /proc/loadavg | awk '{printf "%.1f%%", $1 + $3}')
Last_boot=$(who -b | awk '{print $3,$4}')
LVM_use=$(lsblk | grep 'lvm' | awk '{if ($6 == "lvm") {print "yes"; exit} else {print "no"; exit}}')
Connexions_TCP=$(ss | grep 'tcp' | grep 'ESTAB' | wc -l)
User_log=$(w -h | wc -l)
Network=$(hostname -I | awk '{printf "%s ", $1}' ; ip link show | grep 'link/ether' | awk '{printf "(%s)", $2}')
Sudo=$(cat /var/log/auth.log | grep --text 'sudo' | grep 'COMMAND' | wc -l)

wall "#Architecture: $Architecture
#CPU physical : $CPU_physical
#vCPU : $vCPU
#Memory Usage: $Memory_Usage
#Disk Usage: $Disk_Usage
#CPU load: $CPU_load
#Last boot: $Last_boot
#LVM use: $LVM_use
#Connexions TCP : $Connexions_TCP ESTABLISHED
#User log: $User_log
#Network: IP $Network
#Sudo : $Sudo cmd"
