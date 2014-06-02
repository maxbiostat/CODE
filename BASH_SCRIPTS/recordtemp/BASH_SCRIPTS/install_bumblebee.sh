#/usr/bin/bash
sudo add-apt-repository ppa:bumblebee/stable
sudo apt-get update
sudo apt-get install bumblebee bumblebee-nvidia -y --force-yes
optirun glxspheres
