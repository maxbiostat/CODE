#!/usr/bin/bash
sudo su
apt-get --yes purge unity 
apt-get --yes purge unity-asset-pool unity-services 
apt-get --yes purge unity-lens-* unity-scope-* ubuntu-webapps-*
apt-get --yes purge unity-common
apt-get --yes purge libunity-misc4 libunity-core-6* libunity-webapps*
apt-get --yes purge gir1.2-unity-*
apt-get --yes purge liboverlay-scrollbar* overlay-scrollbar*
apt-get --yes purge appmenu-gtk appmenu-gtk3 appmenu-qt
apt-get --yes purge libufe-xidgetter0
apt-get --yes purge xul-ext-unity xul-ext-websites-integration
apt-get --yes purge firefox-globalmenu thunderbird-globalmenu
