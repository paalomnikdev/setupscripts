#!/bin/bash
#NEED TO RUN FROM SHELL WITH DISABLED X!

echo "welcome to nvidia miner initial script"

if [[ $EUID -ne 0 ]]
then
    printf "%s\n" "This script must be run as root"
    exit 1
fi
export LC_ALL=C
export DISPLAY=:0
echo "export DISPLAY=:0" >> ~/.bashrc
echo "export LC_ALL=C" >> ~/.bashrc
echo "export DISPLAY=:0" >> ~/.profile
echo "export LC_ALL=C" >> ~/.profile
add-apt-repository -y "ppa:graphics-drivers/ppa"
locale-gen --purge en_US.UTF-8
echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale
apt-get update
apt-get upgrade -y
apt-get -y install software-properties-common openssh-server git screen cmake libcrypto++-dev libleveldb-dev libjsoncpp-dev libjsonrpccpp-dev libboost-all-dev libgmp-dev libreadline-dev libcurl4-gnutls-dev ocl-icd-libopencl1 opencl-headers mesa-common-dev libmicrohttpd-dev build-essential supervisor python3-pip
update-grub
echo "alias python=python3.5" >> ~/.bashrc
echo "alias pip=pip3" >> ~/.bashrc
wget "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb"
apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
dpkg -i cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
apt-get -y --allow-unauthenticated install nvidia-390
reboot
