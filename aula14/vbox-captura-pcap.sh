#!/bin/bash

# ref: https://www.virtualbox.org/wiki/Network_tips

vm=amo
pcap_dir=~/reversing/target
now=$(date +%Y%m%d-%H%M%S)
read -p "Malware name (one word): " pcap_name
pcap_file="$pcap_dir/$pcap_name-$now.pcap"

VBoxManage snapshot $vm restorecurrent
VBoxManage modifyvm $vm --nictrace1 on --nictracefile1 $pcap_file
VBoxManage startvm $vm

read -p "Press [ENTER] when finished the analysis..."

#read -p "This will stop the VM. Are you sure [Y/n]? " a
# need handling [ $a = "n" ] && exit

VBoxManage controlvm $vm poweroff
VBoxManage modifyvm $vm --nictrace1 off
