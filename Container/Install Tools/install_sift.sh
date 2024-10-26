#!/bin/bash

##
# This file will download and install SIFT into the Code-Server container completiting the powerup needed to do full DFIR...
#
# To install, open the integrated terminal. (Click the Hamburger -> Terminal -> New Terminal).
# Change directories into the folder where this script is located
# Execute: sudo chmod +x install_sift.sh && sudo ./install_sift.sh
# Enjoy coffee. 
#
# Some of the SIFT components may fail. That is OK. Run the script again. (Or just the cast install line)
##

CAST_VERSION="0.14.50"

cd /tmp

# Install SIFT into the container
wget "https://github.com/ekristen/cast/releases/download/v${CAST_VERSION}/cast-v${CAST_VERSION}-linux-amd64.deb"

#Perform the install of cast
dpkg -i "cast-v${CAST_VERSION}-linux-amd64.deb"

#Use cast to install the SIFT packages in server mode (no GUI) and into the coder user.
cast install --mode=server --user=coder teamdfir/sift-saltstack

#Clean Up
rm "cast-v${CAST_VERSION}-linux-amd64.deb"
rm -rf /var/cache/salt/*