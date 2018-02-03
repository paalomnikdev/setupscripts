#!/bin/bash

if [[ $EUID -ne 0 ]]
then
    printf "%s\n" "This script must be run as root"
    exit 1
fi

systemctl stop lightdm.service
nvidia-xconfig -s -a --allow-empty-initial-configuration \
--cool-bits=12 --registry-dwords="PerfLevelSrc=0x2222" \
--no-sli --connected-monitor="DFP-0" -o /etc/X11/xorg.conf

sed -i '/Driver/a Option "Interactive" "False"' /etc/X11/xorg.conf
sed -i '/    Driver         "nvidia"/ a \ \ \ \ Option         "Coolbits" "28"' /etc/X11/xorg.conf
echo "%sudo  ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
systemctl enable ssh
echo "alias python=python3.5" >> ~/.bashrc
echo "alias pip=pip3" >> ~/.bashrc
source ~/.bashrc
reboot
