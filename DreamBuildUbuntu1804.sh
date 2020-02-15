#!/bin/bash

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE AND NONINFRINGEMENT.
#
# Jayson Bucknell, AA7NM 2020

mkdir -p /opt/dreambuild

# update and install depedencies
apt-get update 
apt-get install -y g++ unzip make libtool git subversion qt5-default libqt5webkit5-dev libqt5svg5-dev libqwt-qt5-dev libpulse-dev libhamlib-dev fftw3-dev libpcap-dev libsndfile-dev libfaad-dev libfaac-dev libspeex-dev libspeexdsp-dev libasound2-dev
apt-get upgrade -y

# build fdk-aac
cd /opt/dreambuild
git clone https://git.code.sf.net/p/opencore-amr/fdk-aac opencore-amr-fdk-aact
cd opencore-amr-fdk-aact/
./autogen.sh
./configure --prefix=/usr --disable-static
make -j $(nproc)
make install
ldconfig
updatedb

# build dream
cd /opt/dreambuild
svn checkout svn://svn.code.sf.net/p/drm/code/ drm-code
cd drm-code/branches/dream-rafa/
qmake CONFIG+=alsa CONFIG+=sound
make -j $(nproc)
cp dream /usr/local/bin/dream
updatedb

# set ownerships to user who called this script
chown -R $SUDO_USER:$SUDO_USER /opt/dreambuild


