# Hardware

* Gigabyte Z270X Ultra Gaming https://www.gigabyte.com/Motherboard/GA-Z270X-Ultra-Gaming-rev-10#kf
* Intel i5 6600K 3.5 Ghz (OC 4.3 - 1.3v)
* NZXT Kraken X52 Water cooler
* G.Skill 16GB DDR4 2400
* EVGA Nvidia 980Ti

# Supported Versions

`config.plist` boots and works with Sierra and High Sierra.

Currently, there is no web drivers for Nvidia in Mojave. You must use either use AMD or IGPU. AMD works out of the box with Lilu and Whatever green kexts found in this repo. IGPU requires modifcations of the config to work.

# Notes

Hardware acceleration is enabled for IGPU while using dedicated graphics. If you have disabled IGPU in BIOS, you can turn it back on, set the size to 128mb and use PCI GPU as default.

# Report

I installed macOS in late August. I have had a stable build since then. The only thing I did that broke things was try to control fans with a program. Upon use, the fans kicked on high and attempting to adjust the speed instantly powered the machine off. I use the built-in motherboard fan controls and unplugged the USB cable from the NZXT pump. I set my own fan curves and have idle temps of 30c and gaming temps of 50-70c.
