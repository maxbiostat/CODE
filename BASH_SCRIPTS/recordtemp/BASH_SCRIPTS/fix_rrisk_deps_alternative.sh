#!/usr/bin/bash
sudo yum install automake libtool gcc glibc-devel glibc-utils.$(uname -m) gdal-libs.$(uname -m) -y
#sudo apt-get install automake libtool gcc libgdal g++-multilib -y
wget https://dl.dropbox.com/u/46408909/OpenBUGS-3.2.2.tar.gz
tar zxvf OpenBUGS-3.2.2.tar.gz
cd OpenBUGS-3.2.2
./configure
make && sudo make install
