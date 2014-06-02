#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo 'About to add megasoftware repository necessary in order to install MEGA'


while true
do
  echo -n "Add megasoftware repository (mandatory) [y]"
  read CONFIRM
  case $CONFIRM in
    y|Y|YES|yes|Yes|'') 
      echo "deb http://update.megasoftware.net/deb/ mega main" > /etc/apt/sources.list.d/megasoftware.list
      echo megasoftware repository added successfully
      echo -n "Downloading MEGA public key to authenticate repository"
      wget http://update.megasoftware.net/megapublickey.txt
      apt-key add megapublickey.txt
      break
	;;
    n|N|no|NO|No)
      echo Selected to not add MEGA repository, the install may fail!
      break
      ;;
    *) echo Please enter yes or no.  To abort press Ctrl+C
  esac
done


echo "We need to run 'apt-get update' now, so that apt-get is aware of what packages megasoftware repo has available."
apt-get update
echo "Now installing mega via 'apt-get install mega'"
apt-get install mega
