#!/usr/bin/bash
sensors | grep Core\ 1 | awk '{print $3}'| sed -e 's/+//g' -e 's/°C//g'
