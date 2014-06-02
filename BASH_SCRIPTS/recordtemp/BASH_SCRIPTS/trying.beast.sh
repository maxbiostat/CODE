#!bin/bash
sudo apt-get install build-essential autoconf automake libtool subversion pkg-config openjdk-6-jdk
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH
cd /usr/local/src && svn checkout http://beagle-lib.googlecode.com/svn/trunk/ beagle-lib
cd beagle-lib
./autogen.sh # if you get an error here you may need to install libtool
./configure
make
sudo make install
make check # tests passed
cd /usr/local/src
sudo svn co http://beast-mcmc.googlecode.com/svn/trunk/ beast-mcmc
cd beast-mcmc
ant
