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

# uninstall previous fdk-aac and dream if any
cd /opt/dreambuild/dream-rafa
make uninstall
cd /opt/dreambuild/fdk-aac
make uninstall
cd ~/
rm -rf /opt/dreambuild
ldconfig
updatedb

