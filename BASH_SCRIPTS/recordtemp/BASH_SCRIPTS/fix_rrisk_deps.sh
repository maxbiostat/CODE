#!/usr/bin/bash
sudo yum install automake libtool gcc glibc-utils.$(uname -m) gdal-libs.$(uname -m) -y
#sudo apt-get install automake libtool gcc libgdal-y
wget https://dl.dropbox.com/u/46408909/openbugs-3.2.2-2.x86_64.rpm
sudo yum localinstall openbugs-3.2.2-2.x86_64.rpm -y
#sudo dpkg -i openbugs-3.2.2-2.x86_64.rpm -y
#sudo apt-get -f install

