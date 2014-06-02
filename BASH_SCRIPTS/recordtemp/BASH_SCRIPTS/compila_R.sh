#!/usr/bin/bash
export FFLAGS="-march=core2 -O3"
export CFLAGS="-march=core2 -O3"
export CXXFLAGS="-march=core2 -O3"
export FCFLAGS="-march=core2 -O3"
./configure --with-tcltk --enable-R-shlib --with-recommended-packages --with-valgrind-instrumentation --enable-memory-profiling --with-system-bzlib  --with-blas --with-lapack --enable-BLAS-shlib
make && make pdf && sudo make install
