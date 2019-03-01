#!/bin/bash

#Packages

echo "----------------- Fetching packages -----------------"
os=$(hostnamectl | grep 'Operating System')
echo $os
if [[ $os == *"Fedora"* ]]; then

	echo "Fedora system detected." 
	sudo dnf install gawk make wget tar bzip2 gzip python unzip perl patch diffutils diffstat git cpp gcc gcc-c++ glibc-devel texinfo chrpath ccache perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue socat findutils which SDL-devel xterm

elif [[ $os == *"Ubuntu"* ]] || [[ $os == *"Debian"* ]] || [[ $os == *"Parrot"* ]]; then

	echo "Ubuntu, debian or parrot detected."
	sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm

elif [[ $os == *"OpenSUSE"* ]]; then

	echo "OpenSUSE detected."
	sudo zypper install python gcc gcc-c++ git chrpath make wget python-xml diffstat makeinfo python-curses patch socat libSDL-devel xterm

elif [[ $os == *"CentOS"* ]]; then

	echo "CentOS detected."
	sudo yum install gawk make wget tar bzip2 gzip python unzip perl patch diffutils diffstat git cpp gcc gcc-c++ glibc-devel texinfo chrpath socat perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue SDL-devel xterm

fi

echo "----------------- Removing old files -----------------"
rm -rf poky-sumo

echo "----------------- Cloning poky -----------------"
git clone -b sumo git://git.yoctoproject.org/poky.git poky-sumo

echo "----------------- Cloning recommended meta-data -----------------"
cd poky-sumo
git clone -b sumo git://git.openembedded.org/meta-openembedded
git clone -b sumo git://git.yoctoproject.org/meta-raspberrypi
git clone -b sumo git://git.yoctoproject.org/meta-security
git clone -b sumo https://github.com/meta-rust/meta-rust.git
git clone git://github.com/OSSystems/meta-browser.git


echo "----------------- Setting up build enviroment -----------------"
source ./oe-init-build-env

cp ../../bblayers.conf conf/bblayers.conf

cp ../../local.conf conf/local.conf

#bitbake-layers add-layer ../meta-raspberrypi
#bitbake-layers add-layer ../meta-openembedded/meta-oe
#bitbake-layers add-layer ../meta-openembedded/meta-python
#bitbake-layers add-layer ../meta-openembedded/meta-perl
#bitbake-layers add-layer ../meta-openembedded/meta-multimedia 
#bitbake-layers add-layer ../meta-openembedded/meta-networking
#bitbake-layers add-layer ../meta-openembedded/meta-gnome
#bitbake-layers add-layer ../meta-openembedded/meta-xfce
#bitbake-layers add-layer ../meta-rust
#bitbake-layers add-layer ../meta-browser


#bitbake core-image-minimal-xfce

#sudo dd if=tmp/deploy/images/raspberrypi3-64/core-image-sato-raspberrypi3.rpi-sdimg of=/dev/sdX
