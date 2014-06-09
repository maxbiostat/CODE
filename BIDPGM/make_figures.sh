#! /usr/bin/bash
Rscript *.R
epstopdf fig_4A.eps && epstopdf fig_4B.pdf && rm *.eps


