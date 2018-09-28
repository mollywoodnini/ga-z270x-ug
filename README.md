# Hardware

* Gigabyte Z270X Ultra Gaming https://www.gigabyte.com/Motherboard/GA-Z270X-Ultra-Gaming-rev-10#kf
* Intel i5 6600K 3.5 Ghz (OC 4.4)
* NZXT Kraken X52 Water cooler
* G.Skill 16GB DDR4 2400
* EVGA Nvidia 980Ti

# Supported Versions

`config.plist` boots and works with Sierra and High Sierra.

Currently, there is no web drivers for Nvidia in Mojave. You must use either use AMD or IGPU. AMD works out of the box with Lilu and Whatever green kexts found in this repo. IGPU requires modifcations of the config to work.

# How to use

The best way to use this EFI config is visit the [releases page](https://github.com/cbabb/ga-z270x-ug/releases). Create an empty `EFI` folder on the mounted EFI partition of the macOS disk. Drag both the `BOOT` and `CLOVER` folders into it. There are no serials present. You will need to generate it with Clover config.

Hardware acceleration is enabled for IGPU. If you have disabled IGPU in BIOS, you can turn it back on, set the size to 128mb and use PCI GPU as default.
