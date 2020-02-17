#!/bin/bash

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE AND NONINFRINGEMENT.
#
# Jayson Bucknell, AA7NM 2020

if [ ! "`whoami`" = "root" ]
then
    echo "Please run this script as root using sudo! (sudo ./DreamBuildUbuntu1804.sh)"
    exit 1
fi

mkdir -p /opt/dreambuild

# update and install depedencies
apt-get update 
apt-get install -y autoconf g++ unzip make libtool git subversion qt5-default libqt5webkit5-dev libqt5svg5-dev libqwt-qt5-dev pulseaudio libpulse-dev libhamlib-dev fftw3-dev libpcap-dev libsndfile-dev libfaad-dev libfaac-dev libspeex-dev libspeexdsp-dev libasound2-dev
apt-get upgrade -y

# build fdk-aac
cd /opt/dreambuild
git clone https://github.com/rafael2k/fdk-aac
cd fdk-aac
chmod u+x autogen.sh
./autogen.sh
./configure --prefix=/usr --disable-static
make -j $(nproc)
make install
ldconfig
updatedb

# build dream
cd /opt/dreambuild
svn checkout svn://svn.code.sf.net/p/drm/code/branches/dream-rafa/
cd dream-rafa
qmake CONFIG+=alsa CONFIG+=sound
make -j $(nproc)
# remove bad dreams
rm -rf /usr/bin/dream
rm -rf /usr/local/bin/dream 
# install dream
make install
# it's over here
ln -s /usr/bin/dream /usr/local/bin/dream
ldconfig
updatedb

# tidy up
apt clean

# set ownerships to user who called this script
chown -R $SUDO_USER:$SUDO_USER /opt/dreambuild


