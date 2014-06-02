#!/usr/bin/bash
## This script stores the "Core 1" temperature [of single processor machine] in a 10 seconds base.
## It is designed to kick in every day [using crontab], deleting info from the previous day.
## The script tplot.sh can then be used to vizualise the temperature graph
## It depends on lm-sensors, to get it do "sudo apt-get install lm-sensors" under Debian/Ubuntu/Mint or "sudo yum install lm_sensors" under Fedora 
rm temps.txt # delete
echo > temps.txt # create
#fill up
while true; do sh t.sh >> temps.txt; sleep 10; done
