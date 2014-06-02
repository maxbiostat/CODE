#!/usr/bin/bash
sudo apt-get install libc6-dev-i386 -y
export FFLAGS="-march=native -O3 -pipe"
export CFLAGS="-march=native -O3 -pipe"
export CXXFLAGS="-march=native -O3 -pipe"
export FCFLAGS="-march=native -O3 -pipe"
./configure
make && sudo make install
