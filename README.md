# Hardware

* [Gigabyte Z270X Ultra Gaming](https://www.gigabyte.com/Motherboard/GA-Z270X-Ultra-Gaming-rev-10#kf)
* [Intel i5 6600K](https://ark.intel.com/products/88191/Intel-Core-i5-6600K-Processor-6M-Cache-up-to-3-90-GHz-) 3.5 Ghz (OC 4.3 - 1.3v)
* [NZXT Kraken X52](https://www.nzxt.com/products/kraken-x52) Water cooler
* G.Skill 16GB DDR4 2400
* EVGA Nvidia 980Ti
* 850 Evo 250GB
* WD Blue 1TB, 4TB
* WD Green 2TB

# Supported Versions

High Sierra 10.13.6.

Currently, there is no web drivers for Nvidia in Mojave. You must use either use AMD or IGPU. AMD works out of the box with `Lilu` and `WhateverGreen` kexts found in this repo. IGPU requires modifcations of the config to work.

# Installation

Please read all of the instructions before you start installing!

## Pre-Install

* Create a vanilla installer and clone or download this repo.
* Edit the `post-config.plist` to fill in the blanks for `SMBIOS` !!
* Copy USB_EFI to mounted USB EFI partition.
* Compress INSTALL_EFI and copy to USB.
* Boot Install from USB.
* Format SSD as APFS.
* Start install as normal.
* At 72% system will reboot.
* Boot from USB - *Preboot on drive_Name*. System will reboot shortly.
* Boot from USB - *Preboot on drive_Name*.
* Install will complete. Took 10 minutes for me.
* Boot from USB - Now you can choose *macOS on drive_Name*

## Post-Install

* Copy INSTALL_EFI.zip from USB to SSD and extract.
* The USB `config.plist` is only usable for booting the USB. You must instead use the `post-config.plist` to complete install.
* Rename `post-config.plist` to `config.plist`.
* Copy INSTALL_EFI to mounted SSD EFI partition.
* Install required kexts using a kext installer like [KextWizard](https://www.osx86.net/files/file/4304-kext-wizard-3711/) or do it manually. The bare minimum will remain in Clover for Recovery. See folder Post_Install_Kexts.
* **Nvidia Only:** You need `EmuVariableUefi-64.efi` in Clover to make the GPU work. It's already there. Install the web drivers.
* **AMD Only:** Works out of box. You do need to remove Nvidia specifics from the config. Remove `nvda_drv=1` from Boot Arguments. Remove `NvidiaWeb=Yes` from System Parameters.
* Install any additional required software now for devices. 
* Rebuild kext cache `sudo kextcache -i /`
* Shutdown. Do not restart.
* You can now boot from the SSD instead of the USB.
* **Nvidia only:** If the system booted without GPU acceleration, open System Preferences and change to use Nvidia Web Drivers and reboot.

## NZXT Control

Unfortunately it is impossible to control the pump speed with any OS other than Windows. As a result you must alter how the hardware is plugged in. You must make sure the radiator fans are plugged into a header that is PWM capable. For example my radiator fans are plugged into a splitter, and the splitter plugged into SYSTEM_FAN_2. In BIOS fan control SYSTEM_FAN_2 is set to monitor CPU temp using a custom fan curve. Idle temps as low as 23c, average of 30c. Standard casual use between 30-45c. Gaming between 50-70c. The pump is plugged into CPU_FAN and functions on its own. You do need to remove the USB plug from it. This means no lights (doesn't bother me). If you do not, it will run using Silent mode all the time. This results in high temps. 

## Hardware Accel with IGPU

Hardware acceleration is enabled for IGPU while using dedicated graphics. If you have disabled IGPU in BIOS, you can turn it back on, set the size to 128mb and use PCI GPU as default.

## Brightness Control

If your monitor supports brightness control within Windows, you can control it in macOS.
https://github.com/KAMIKAZEUA/NativeDisplayBrightness/releases

You can map the keys how you like. However, Logitech G keys do not allow mapping past F12. You can use an LUA script to map it as you wish. I have a G910. I forked an existing gist and modified it. Unassigned G6 and G7, then scripted G6 and G7 to be F18 and F19. The script will override what you set through the UI. If you do not unassign you will get the error tone when adjusting brightness.
https://gist.github.com/cbabb/85047be7ced0f789c3c7a5941603cd7a

## Audio Input/Output

AppleALC with an unmodified AppleHDA, using layout 11.

* Out: Digital Out, Internal Speakers, Line out, Line out.
* In: Internal mic, Line in
* USB In: Logitech HD Pro Webcam C910, Razer Kraken 7.1

Internal speakers is used when plugging into the rear (green) speaker jack. When the webcam is plugged in, it creates an audio problem for programs like Premiere Pro or Audition. Not sure what the issue is there. If you are a gamer, like myself, and do like to stream I have not ran into any problem using a USB headset with mic or the webcam. If you want to set that up, [here is a great video](https://www.youtube.com/watch?v=F2OzfwFHjhE).

# Final notes

I installed macOS in late August. I have had a stable build since then. The only thing I did that broke things was try to control fans with a program. Upon use, the fans kicked on high and attempting to adjust the speed instantly powered the machine off.

[Need help?](https://www.reddit.com/message/compose/?to=cbabbx)
