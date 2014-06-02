#!bin/bash
#sudo apt-get install build-essential autoconf automake libtool subversion pkg-config openjdk-6-jdk openjdk-7-jdk
svn checkout http://beagle-lib.googlecode.com/svn/trunk/ beagle-lib
cd beagle-lib
#./autogen.sh -lcuda=/usr/local/cuda-5.0/
./autogen.sh
./configure --prefix=$HOME
sudo make install
#export LD_LIBRARY_PATH=/usr/lib/nvidia
export LD_LIBRARY_PATH=/home/max/lib


