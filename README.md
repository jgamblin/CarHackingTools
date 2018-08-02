
# WARNING!  THIS IS STILL IN TESTING!  PLEASE DONT USE!

*_I am still testing and writing this code.  It likely doesn't work fully and isn't fully documented._*

# CarHacking.Tools

[CarHacking.Tools](CarHacking.Tools) is a scripts collection of scripts to help jump start car research (and hacking?). All the scripts are designed to work on [Ubuntu 18.04](ubuntu.com).


# Included Tools

The following tools are installed and configured automatically:

|Tool Name     |Link         | Notes |
|-------------|-------------|-----|
| Can-Utils | https://github.com/linux-can/can-utils | |
| Canbus-Utils |  https://github.com/digitalbond/canbus-utils | |
| Cantact-App |  https://github.com/linklayer/cantact-app/ | |
| Caringcaribou |  https://github.com/CaringCaribou/caringcaribou | |
| GNUradio |  https://www.gnuradio.org/ | |
| c0f |  https://github.com/zombieCraig/c0f | |
| ICSim |  https://github.com/zombieCraig/ICSim | |
| KatyOBD |  https://github.com/YangChuan80/KatyOBD | |
| Kayak |  http://kayak.2codeornot2code.org/ | |
| OBD-Monitor |  https://github.com/dchad/OBD-Monitor | |
| PyOBD |  http://www.obdtester.com/pyobd ||
| SavvyCAN |  http://www.savvycan.com/ | |
| Scantool |  https://www.scantool.net/ | |
| Socketcand |  https://github.com/dschanoeh/socketcand | |
| UDSim |  https://github.com/zombieCraig/UDSim | |
| Wireshark |  https://www.wireshark.org/ | . |  


# Install

## Virtual Machine

An OVA is available on [CarHacking.Tools](CarHacking.Tools) to download.

[Alpha OVA](https://carhacking.tools/install/alpha/alpha180718/CarHackingDesktopAlpha.ova)

## Full Desktop

To Install The Full Desktop:
```
Git clone https://github.com/jgamblin/carhackingtools
cd CarHackingTools
sudo chmod +x *.sh
./workstationinstall.sh
```

## Tools Only

To Install Only The Tools:
```
Git clone https://github.com/jgamblin/carhackingtools
cd CarHackingTools
sudo chmod +x *.sh
./toolinstall.sh
```

## Warning
I likely don't know what I am doing and this could be done faster, better and simpler some other way. These scripts could also break your car (seriously) and make you cry.
