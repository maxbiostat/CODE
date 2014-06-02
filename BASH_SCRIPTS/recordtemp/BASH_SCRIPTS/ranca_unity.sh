#!/usr/bin/bash
sudo su
add-apt-repository ppa:gnome3-team/gnome3 && apt-get -f update
apt-get -f install gdm gnome-shell gnome-tweak-tool gnome-session-fallback 
