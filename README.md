# Hardware

* Gigabyte Z270X Ultra Gaming https://www.gigabyte.com/Motherboard/GA-Z270X-Ultra-Gaming-rev-10#kf
* Intel i5 6600K 3.5 Ghz (OC 4.3 - 1.3v)
* NZXT Kraken X52 Water cooler
* G.Skill 16GB DDR4 2400
* EVGA Nvidia 980Ti

# Supported Versions

`config.plist` boots and works High Sierra 10.13.6.

Currently, there is no web drivers for Nvidia in Mojave. You must use either use AMD or IGPU. AMD works out of the box with `Lilu` and `WhateverGreen` kexts found in this repo. IGPU requires modifcations of the config to work.

# Installation

Please read all of the instructions before you start installing!

## Pre-Install

* Create a vanilla installer and clone this repo.
* Edit the `post-config.plist` to fill in the blanks for `SMBIOS` !!
* Copy USB_EFI to mounted USB EFI partition.
* Compress INSTALL_EFI and copy to USB.
* Boot Install from USB.
* Format SSD as APFS.
* Start install as normal.
* At 72% system will reboot.
* Boot from USB - Preboot on *drive_Name*. System will reboot shortly.
* Boot from USB - Preboot on *drive_Name*.
* Install will complete. Took 10 minutes for me.
* Boot from USB - Now you can choose macOS on <driveName>

## Post-Install

* Copy INSTALL_EFI.zip from USB to SSD and extract.
* The `config.plist` is only usable for booting the USB. You must instead use the `post-config.plist` to complete install.
* Rename `post-config.plist` to `config.plist`.
* Copy INSTALL_EFI to mounted SSD EFI partition.
* Install required kexts using a kext installer like [KextWizard](https://www.osx86.net/files/file/4304-kext-wizard-3711/) or do it manually. The bare minimum will remain in Clover for Recovery. See folder Post_Install_Kexts.
* Install Nvidia web drivers. You need `EmuVariableUefi-64.efi` in Clover to make the GPU work. It's already there.
* Install any additional required software now for devices. 
* Rebuild kext cache `sudo kextcache -i /`
* Shutdown. Do not restart.
* You can now boot from the SSD instead of the USB.
* If the system booted without GPU acceleration, open System Preferences and change to use Nvidia Web Drivers and reboot.

## NZXT Control

Unfortunately it is impossible to control the pump speed with any OS other than Windows. As a result you must alter how the hardware is plugged in. You must make sure the radiator fans are plugged into a header that is PWM capable. For example my radiator fans are plugged into a splitter, and the splitter plugged into SYSTEM_FAN_2. In BIOS fan control SYSTEM_FAN_2 is set to monitor CPU temp using a custom fan curve. Idle temps as low as 23c, average of 30c. Standard casual use between 30-45c. Gaming between 50-70c.

## Hardware Accel with IGPU

Hardware acceleration is enabled for IGPU while using dedicated graphics. If you have disabled IGPU in BIOS, you can turn it back on, set the size to 128mb and use PCI GPU as default.

## Brightness Control

If your monitor supports brightness control within Windows, you can control it in macOS.
https://github.com/KAMIKAZEUA/NativeDisplayBrightness/releases

You can map the keys how you like. However, Logitech G keys do not allow mapping past F12. You can use an LUA script to map it as you wish. I have a G910. I forked an existing gist and modified it.
https://gist.github.com/cbabb/85047be7ced0f789c3c7a5941603cd7a

# Final notes

I installed macOS in late August. I have had a stable build since then. The only thing I did that broke things was try to control fans with a program. Upon use, the fans kicked on high and attempting to adjust the speed instantly powered the machine off.

[Need help?](https://www.reddit.com/message/compose/?to=cbabbx)
