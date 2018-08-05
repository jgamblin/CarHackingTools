#!/bin/bash
# Ubuntu Car Hacking Workstation Setup
# TODO:
# Make Sure Icons Work.
# General Clean Up.
set -e

# Set Install Dir Beacon
installdir=$(pwd)

# Setup Tools Directory
sudo mkdir -p /tools
sudo chmod -R 0777 /tools
cd /tools || exit

# Set Background Images
mkdir -p images
cd images || exit
wget https://carhacking.tools/install/images/background.gif -O background.gif
gsettings set org.gnome.desktop.background picture-uri "/tools/images/background.gif"
cd .. || exit

# Configure Desktop
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.screensaver picture-uri '/dev/null'
gsettings set org.gnome.desktop.screensaver primary-color '#000000'
gsettings set org.gnome.desktop.screensaver secondary-color '#000000'
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false
gsettings set org.gnome.login-screen disable-user-list true
gsettings set org.gnome.nautilus.desktop trash-icon-visible false
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Terminal.desktop', 'Cantact.desktop', 'ICSim.desktop', 'ICSimControls.desktop', 'SavvyCAN.desktop', 'wireshark.desktop', 'arduino.desktop', 'moserial.desktop']"
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

#Disable Power Managment
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

#Running The Tool Install script
cd "$installdir"
./toolinstall.sh
