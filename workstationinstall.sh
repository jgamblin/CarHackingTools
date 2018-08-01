#!/bin/bash
# Ubuntu Car Hacking Workstation Setup
# TODO:
# Fix Python-Obd Install
# Fix OBD-Monitor Install

set -e

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
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Terminal.desktop', 'Cantact.desktop', 'ICSim.desktop', 'ICSimControls.desktop', 'SavvyCAN.desktop', 'KayakInstall.desktop']"
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

#Disable Power Managment
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

#Running The Tool Install script
sh ./toolinstall.sh

# Make Desktop Icons

printf "Configuring Desktop"
printf "\n"


mkdir -p -p icons
cd icons || exit

cat << EOF > BlueLog.desktop
[Desktop Entry]
Name=BlueLog
Type=Application
Path=/tools/Bluelog
Exec=/tools/Bluelog/bluelog
Icon=/tools/Bluelog/www/images/bluelog_logo.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

wget https://carhacking.tools/install/images/cantact.png -O cantact.png

cat << EOF > Cantact.desktop
[Desktop Entry]
Name=Cantact
Type=Application
Path=/tools/cantact-app/cantact/bin
Exec=sudo -H /tools/cantact-app/cantact/bin/cantact
Icon=/tools/icons/cantact.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

wget https://carhacking.tools/install/images/icsim.png -O icsim.png

cat << EOF > ICSim.desktop
[Desktop Entry]
Name=ICSim
Type=Application
Path=/tools/ICSim/
Exec=/tools/ICSim/icsim vcan0
Icon=/tools/icons/icsim.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

cat << EOF > ICSimControls.desktop
[Desktop Entry]
Name=ICSim Controls
Type=Application
Path=/tools/ICSim/
Exec=/tools/ICSim/controls vcan0
Icon=/tools/icons/icsim.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

wget https://carhacking.tools/install/images/kayak.png -O kayak.png

cat << EOF > KayakInstall.desktop
[Desktop Entry]
Name=Kayak Install
Type=Application
Path=/tools/kayak
Exec=/tools/kayak/Kayak-1.0-SNAPSHOT-linux.sh
Icon=/tools/icons/kayak.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

wget https://carhacking.tools/install/images/KatyOBD.png -O KatyOBD.png

cat << EOF > KatyOBD.desktop
[Desktop Entry]
Name=KatyOBD
Type=Application
Path=/tools/KatyOBD
Exec=sudo -H python KatyOBD.py
Icon=/tools/icons/KatyOBD.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

sudo rm ~/Desktop/SavvyCAN.desktop
sleep 15
chmod 755 *.desktop
cp *.desktop ~/.local/share/applications
cd .. || exit

cd ~/.local/share/applications || exit
chmod 755 *.desktop
cd .. || exit
