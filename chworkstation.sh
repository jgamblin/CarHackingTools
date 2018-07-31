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

#setup scipt
clear
printf "Setting Up Base System & Updates"
printf "\n"

# Update System
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y -qq < /dev/null > /dev/null
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq < /dev/null > /dev/null

#  Java Fixes
echo oracle-java10-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:webupd8team/java < /dev/null > /dev/null
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y -qq < /dev/null > /dev/null

#Base Package Install (Packages Listed Invidually For Easy Customazation/Trobule Shooting.)
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq  \
aircrack-ng \
ant \
autoconf \
automake \
bison \
blueman \
bluetooth \
bluez \
bluez \
bluez-tools \
btscanner \
build-essential \
can-utils \
cpp \
cryptsetup \
curl \
ess \
flex \
gcc \
git \
gnuradio \
gqrx-sdr \
htop \
jq \
libbluetooth-dev \
libconfig-dev \
libgps-dev \
libsdl2-dev \
libsdl2-image-dev \
libsdl2-ttf-dev \
libsqlite3-dev \
libtool \
maven \
net-tools \
netbeans \
npm \
oracle-java8-installer \
oracle-java8-set-default \
python \
python-dev \
python-pip \
python-serial \
python-wxtools \
ruby \
ruby-dev \
software-properties-common \
sqlite \
tree \
tree \
tshark \
unrar \
unzip \
wget \
wireshark \
< /dev/null > /dev/null


#Python Pip
python -m pip uninstall pip  # this might need sudo
sudo apt install --reinstall python-pip

# Starting Car Hacking Tool Installation

printf "Instaling Tools"
printf "\n"

# Bluelog
# Read The Docs: https://github.com/MS3FGX/Bluelog
git clone https://github.com/MS3FGX/Bluelog.git
cd Bluelog || exit
sudo make install
cd .. || exit

# Can-Utils:
# Read The Docs: https://github.com/linux-can/can-utils
# More Reading: # More Reading: https://discuss.cantact.io/t/using-can-utils/24
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq can-utils < /dev/null > /dev/null

# Canbus-utils
# Read The Docs Here: https://github.com/digitalbond/canbus-utils
# More Reading:  http://www.digitalbond.com/blog/2015/03/05/tool-release-digital-bond-canbus-utils/
git clone https://github.com/digitalbond/canbus-utils
cd canbus-utils || exit
npm install
cd .. || exit

# Cantact-App
# Read The Docs Here: https://github.com/linklayer/cantact-app/
mkdir -p cantact-app
cd cantact-app || exit
wget https://github.com/linklayer/cantact-app/releases/download/v0.3.0-alpha/cantact-v0.3.0-alpha.zip
sudo unzip cantact-v0.3.0-alpha.zip
sudo rm cantact-v0.3.0-alpha.zip
cd .. || exit

# Caringcaribou
# Read The Docs Here: https://github.com/digitalbond/canbus-utils
pip install --user python-can
git clone https://github.com/CaringCaribou/caringcaribou

# c0f
# Read the Docs Here: https://github.com/zombieCraig/c0f
sudo gem install c0f

# ICSim
# Read The Docs Here: https://github.com/zombieCraig/ICSim
# Quick Start:  ./setup_vcan.sh &&  ./icsim vcan0 && ./controls vcan0
git clone https://github.com/zombieCraig/ICSim.git

# KatyOBD
# Read The Docs Here:
git clone https://github.com/YangChuan80/KatyOBD
#Fix Typo in KatyOBD
cd KatyOBD || exit
sed -i 's/tkinter/Tkinter/g' KatyOBD.py
cd .. || exit

# Kayak
# Read The Docs Here: http://kayak.2codeornot2code.org/
# To Install ./Kayak-1.0-SNAPSHOT-linux.sh --silent
mkdir -p -p kayak
cd kayak || exit
curl http://kayak.2codeornot2code.org/Kayak-1.0-SNAPSHOT-linux.sh > Kayak-1.0-SNAPSHOT-linux.sh
chmod +x Kayak-1.0-SNAPSHOT-linux.sh
cd .. || exit

# OBD-Monitor
git clone https://github.com/dchad/OBD-Monitor

# Python-ODB
# Read The Docs Here: https://python-obd.readthedocs.io/en/latest/
pip install --user pySerial

git clone https://github.com/brendan-w/python-OBD
cd python-OBD || exit
sudo python setup.py install
cd .. || exit

# PyOBD:
git clone https://github.com/Pbartek/pyobd-pi.git

# SavvyCAN
# Read The Docs Here: https://github.com/collin80/SavvyCAN

# Start With QT:
mkdir -p QT
cd QT || exit
cat << EOF > qt-noninteractive-install-linux.qs
function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton);
    })
    installer.setMessageBoxAutomaticAnswer("cancelInstallation", QMessageBox.Yes);
}
Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton, 3000);
}
Controller.prototype.CredentialsPageCallback = function() {
    var widget = gui.currentPageWidget();
    widget.loginWidget.EmailLineEdit.setText("");
    widget.loginWidget.PasswordLineEdit.setText("");
    gui.clickButton(buttons.NextButton, 500);
}
Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}
Controller.prototype.TargetDirectoryPageCallback = function()
{
    var widget = gui.currentPageWidget();
    if (widget != null) {
        widget.TargetDirectoryLineEdit.setText("/opt/QT");
    }
    gui.clickButton(buttons.NextButton);
}
Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();
    function trim(str) {
        return str.replace(/^ +/,"").replace(/ *$/,"");
    }
    var packages = trim("qt.qt5.5111.gcc_64,qt.qt5.5111.qtwebengine,qt.qt5.5111.qtwebengine.gcc_64").split(",");
    if (packages.length > 0 && packages[0] !== "") {
        widget.deselectAll();
        for (var i in packages) {
            var pkg = trim(packages[i]);
            widget.selectComponent(pkg);
        }
    }
    gui.clickButton(buttons.NextButton);
}
Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}
Controller.prototype.StartMenuDirectoryPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}
Controller.prototype.ReadyForInstallationPageCallback = function()
{
    gui.clickButton(buttons.NextButton);
}
Controller.prototype.FinishedPageCallback = function() {
    var checkBoxForm = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm
    if (checkBoxForm && checkBoxForm.launchQtCreatorCheckBox) {
        checkBoxForm.launchQtCreatorCheckBox.checked = false;
    }
    gui.clickButton(buttons.FinishButton);
}
EOF

wget https://s3.amazonaws.com/rstudio-buildtools/qt-unified-linux-x64-3.0.5-online.run
chmod +x qt-unified-linux-x64-3.0.5-online.run

echo "Installing Qt, this will take a while."
echo " - Ignore warnings about QtAccount credentials and/or XDG_RUNTIME_DIR."
echo " - Do not click on any Qt setup dialogs, it is controlled by a script."
sudo ./qt-unified-linux-x64-3.0.5-online.run --script  qt-noninteractive-install-linux.qs
cd .. || exit

# SavvyCan Install
git clone https://github.com/collin80/SavvyCAN.git
cd SavvyCAN || exit
sudo /opt/QT/5.11.1/gcc_64/bin/qmake
sudo make
sudo make install
sudo ./install
cd .. || exit


# Scantool
# Read The Docs Here: https://samhobbs.co.uk/2015/04/scantool-obdii-car-diagnostic-software-linux
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq scantool < /dev/null > /dev/null

# Socketcand
# Read The Docs Here: https://github.com/dschanoeh/socketcand
git clone http://github.com/dschanoeh/socketcand.git
cd socketcand || exit
autoconf
./configure --without-config
 make clean
make
sudo make install
cd .. || exit

# Udsim
# Read The Docs Here: https://github.com/zombieCraig/UDSim
git clone https://github.com/zombieCraig/UDSim
cd UDSim/src || exit
make
cd .. || exit
cd .. || exit



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
