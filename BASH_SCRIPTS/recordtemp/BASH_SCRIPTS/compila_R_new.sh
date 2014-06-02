#!/usr/bin/bash
export FFLAGS="-march=native -O3"
export CFLAGS="-march=native -O3"
export CXXFLAGS="-march=native -O3"
export FCFLAGS="-march=native -O3"

./configure --enable-BLAS-shlib --with-lapack --enable-R-shlib --enable-memory-profiling --with-system-pcre --with-system-zlib --with-system-bzlib --enable-prebuilt-html

make
make check

make pdf
make info

make install
make install-info
make install-pdf
