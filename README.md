# Hardware

* [Gigabyte Z270X Ultra Gaming](https://www.gigabyte.com/Motherboard/GA-Z270X-Ultra-Gaming-rev-10#kf)
* [Intel i5 6600K](https://ark.intel.com/products/88191/Intel-Core-i5-6600K-Processor-6M-Cache-up-to-3-90-GHz-) 3.5 Ghz (OC 4.3 - 1.3v)
* [NZXT Kraken X52](https://www.nzxt.com/products/kraken-x52) Water cooler
* G.Skill 16GB DDR4 2400
* EVGA Nvidia 980Ti
* 850 Evo 250GB
* WD Blue 1TB, 4TB
* WD Green 2TB
* [Dell SE2717H/HX](https://www.newegg.com/Product/Product.aspx?Item=N82E16824260491)

# Supported Versions

High Sierra 10.13.6.

Currently, there is no web drivers for Nvidia in Mojave. You must use either use AMD or IGPU. AMD works out of the box with `Lilu` and `WhateverGreen` kexts found in this repo. IGPU requires booting with a fake ID at first until you generate kextcache with the proper platform ID for next boot.

# Tools and Sources

My first attempt from nothing involved [using a VM](https://techsviewer.com/install-macos-sierra-virtualbox-windows/) since I did not have access to a real Mac. It resulted in the first two USB creations to be slighly bugged. I tried the vanilla method and Unibeast. I found a patching app from [dosdude](http://dosdude1.com/highsierra/) that worked. It was enough to get me started, albiet not how I want. Making a USB install from a VM was a struggle, on top of only being able to use 1024x768 resolution due to VM limitations.

* [Clover Config](https://mackie100projects.altervista.org/download-clover-configurator/) for learning what and where things are.
* [KextWizard](https://www.osx86.net/files/file/4304-kext-wizard-3711/) to install kexts easily without having to manually do it.
* Xcode for properly editing plist files. Clover config is known to cause problems according to RehabMan. As was proven to me when I was making patches for things.
* [GitBook Hackintosh Guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/) for explanations and details on each part of the process.
* [Clover Installer](https://bitbucket.org/RehabMan/clover/downloads/) RehabMan fork to make a generic EFI.
* 

# Installation

Please read all of the instructions before you start installing! For the sake of avoiding confusion for myself and others, I made two EFI folders.

## Pre-Install

* Create a vanilla installer and clone or download this repo.
* Edit the `post-config.plist` in SSD_EFI to fill in the blanks for `SMBIOS` !!
* Copy USB_EFI to mounted USB EFI partition.
* Compress SSD_EFI and copy to USB.
* Boot Install from USB.
* Format SSD as APFS.
* Start install as normal.
* At 72% system will reboot.
* Boot from USB - *Preboot on drive_Name*. System will reboot shortly.
* Boot from USB - *Preboot on drive_Name*.
* Install will complete. Took 10 minutes for me.
* Boot from USB - Now you can choose *macOS on drive_Name*

## Post-Install

* Copy SSD_EFI.zip from USB to SSD and extract.
* The USB `config.plist` is only usable for booting the USB. You must instead use the `post-config.plist` to complete install.
* Rename `post-config.plist` to `config.plist`.
* Copy SSD_EFI to mounted SSD EFI partition.
* Install required kexts using a kext installer like KextWizard or do it manually. The bare minimum will remain in Clover for Recovery. See folder Post_Install_Kexts.
* **Nvidia Only:** You need `EmuVariableUefi-64.efi` in Clover to make the GPU work. It's already there. Install the web drivers.
* **AMD Only:** Works out of box. You do need to remove Nvidia specifics from the config. Remove `nvda_drv=1` from Boot Arguments. Remove `NvidiaWeb=Yes` from System Parameters.
* Install any additional required software now for devices. 
* Rebuild kext cache `sudo kextcache -i /`
* Shutdown. Do not restart.
* You can now boot from the SSD instead of the USB.
* **Nvidia only:** If the system booted without GPU acceleration, open System Preferences and change to use Nvidia Web Drivers and reboot.

## NZXT Control

**Specific to my build:** Unfortunately it is impossible to control the pump speed with any OS other than Windows. As a result you must alter how the hardware is plugged in. You must make sure the radiator fans are plugged into a header that is PWM capable. For example my radiator fans are plugged into a splitter, and the splitter plugged into SYSTEM_FAN_2. In BIOS fan control SYSTEM_FAN_2 is set to monitor CPU temp using a custom fan curve. Idle temps as low as 23c, average of 30c. Standard casual use between 30-45c. Gaming between 50-70c. The pump is plugged into CPU_FAN and functions on its own. You do need to remove the USB plug from it. This means no lights (doesn't bother me). If you do not, it will run using Silent mode all the time. This results in high temps. 

## Hardware Accel with IGPU

Hardware acceleration is enabled for IGPU 6600K while using dedicated graphics. If you have disabled IGPU in BIOS, you can turn it back on, set the size to 128mb and use PCI GPU as default. If you are using a 6700K you don't need to change the platform ID as they are the same.

## Brightness Control

If your monitor supports brightness control within Windows, as mine does, you can [control it in macOS](https://github.com/KAMIKAZEUA/NativeDisplayBrightness/releases). You can map the keys how you like using this app. However, Logitech G keys do not allow mapping past F12. You can use an LUA script to map it as you wish. I have a [G910](https://www.logitechg.com/en-us/products/gaming-keyboards/rgb-gaming-keyboard-g910.html). I forked an existing gist and modified it. Unassigned G6 and G7, then scripted G6 and G7 to be F18 and F19. The script will override what you set through the UI. If you do not unassign you will get the error tone when adjusting brightness. You can see that script here: https://gist.github.com/cbabb/85047be7ced0f789c3c7a5941603cd7a

## Audio Input/Output

AppleALC with an unmodified AppleHDA, using layout 11.

* Out: Digital Out, Internal Speakers, Line out, Line out.
* USB Out: Razer Kraken 7.1
* In: Internal mic, Line in
* USB In: Logitech HD Pro Webcam C910, Razer Kraken 7.1

Internal speakers is used when plugging into the rear (green) speaker jack. If you are a gamer, like myself, and do like to stream I have not ran into any problem using a USB headset with mic or the webcam. If you want to set that up, [here is a great video](https://www.youtube.com/watch?v=F2OzfwFHjhE). The only issue I have with audio is using Adobe programs. Audition will not properly work with USB mics. I have tried both of my devices and the program reports all audio as suddenly not working.

# Final notes

I installed macOS in late August. I had a mostly stable build while learning. The only thing I did that broke things was try to control fans with a program. Upon use, the fans kicked on high and attempting to adjust the speed instantly powered the machine off. Little bugs here and there prompted me to reinstall after learning a lot. I mainly made this for myself because I forget *a lot* of the stuff I do. Once I perfect something I like to know how I can repeat it. I have at this point, just one issue as metioned above. I managed to solve a lot otherwise. It's stable, cool and silent.

[Need help?](https://www.reddit.com/message/compose/?to=cbabbx)
