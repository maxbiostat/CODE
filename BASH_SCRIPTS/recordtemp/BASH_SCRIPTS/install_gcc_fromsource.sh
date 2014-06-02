#!/usr/bin/bash
export GCC_SDIR=pwd
./contrib/download_prerequisites # installing dependencies
cd ~/
mkdir objdir
cd objdir
srcdir/configure
