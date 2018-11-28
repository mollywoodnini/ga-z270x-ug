# Contents

1. [Hardware](#hardware)
2. [Supported Versions](#supported-versions)
3. [Tools and Sources](#tools-and-sources)
4. [Kexts](#kexts)
5. [Installation](#installation)
    1. [BIOS](#bios)
    2. [Pre-Install](#pre-install)
    3. [Post-Install](#post-install)
    4. [NVRAM](#nvram)
    5. [Water cooling](#water-cooling)
    6. [IGPU Options](#igpu-options)
    7. [USB Port Patching](#usb-port-patching)
6. [Gaming](#gaming)
7. [Temperatures](#temperatures)
8. [Brightness Control](#brightness-control)
9. [Audio Input/Output](#audio-inputoutput)
10. [Back it up!](#back-it-up)
11. [Final Notes](#final-notes)

# Hardware

[Image](https://lh3.googleusercontent.com/bJwQTQrU3FZzbroALtFoXNoaqq3OoUtAW0H_spIx0SzBvYnVR7z7N68JnU7q6unJFpousxQuk7lE1WgwL7BiUSi3lTnBIsASxMoX06okXhHp47I_Bxf0vQ5G-GR7BhzGIs1ZEcKoKgT84lFvq5Qa5XF0zV6JG_sUl_8vwbYh8SXlQ_DJh9eh8iiSlsWFBTSXcixMnFxzhK9TroWygfZzLxAwAnFhTZmyXScv-iAwzaTQcTFTo_Nk_97x5OYcW0GktExh_81miv79PKEAPffOjD2MVXbRAZ7d1m0Jz5rlCzQYPo4aV6Ca9dcShtUSXhZKnVXc3hJSfimesFz2e-61Dc1F_RtLdscux2mByzRPpwPgE_61NJCxmKIM3meARF-M5N5jW6QExbcRUb2ehvh5NGV-L0j3bgUXVIBmMxmg32Ry4UUAw2KhWTRE-PokpGvb67FF0kLb8FLRgKG1bhdZC9bbBH_ooOOMI1DT9A3Fm0Ek083MxQ3HWDhhMat9dLAoNQ4ztx8qu7IGZ96TkaRQkaZsEP-TbZ1zE_uixtcrh7kciLIAvvUpWynxMhz-BBw6y-vYEU01sXD1muq9Cx-AJ8ZjfrJ2NON3grOexs5Z6t3WsDX_neF5Rcvu8gKyuM2EvrfxMae9Y0je6QaHE_Yvttj3yTQNPQXVqhAVWAH0KRhH9Q=w908-h681-no)

* [Gigabyte Z270X Ultra Gaming](https://www.gigabyte.com/Motherboard/GA-Z270X-Ultra-Gaming-rev-10#kf)
* [Intel i5 6600K](https://ark.intel.com/products/88191/Intel-Core-i5-6600K-Processor-6M-Cache-up-to-3-90-GHz-) 3.5 Ghz (OC 4.3)
* [NZXT Kraken X52 AIO](https://www.nzxt.com/products/kraken-x52) Water cooler
* G.Skill 16GB DDR4 2400
* EVGA Nvidia 980Ti
* 850 Evo 250GB
* WD Blue 1TB, 4TB
* WD Green 2TB
* [Dell SE2717H/HX](https://www.newegg.com/Product/Product.aspx?Item=N82E16824260491)

# Supported Versions

High Sierra 10.13.6.

Currently, there is no web drivers for Nvidia in Mojave. You must use either use AMD or IGPU. AMD works out of the box with `Lilu` and `WhateverGreen` kexts found in this repo. IGPU requires booting with a fake ID at first until you generate kextcache with the proper platform ID for next boot. If Nvidia drivers for Mojave get release, I'll update this with a version for it.

# Tools and Sources

My first attempt from nothing involved [using a VM](https://techsviewer.com/install-macos-sierra-virtualbox-windows/) since I did not have access to a real Mac. It resulted in the first two USB creations to be slighly bugged. I tried the vanilla method and Unibeast. I found a patching app from [dosdude](http://dosdude1.com/highsierra/) that worked. It was enough to get me started, albiet not how I want. Making a USB install from a VM was a struggle, on top of only being able to use 1024x768 resolution due to VM limitations.

* [Clover Config](https://mackie100projects.altervista.org/download-clover-configurator/) for learning what and where things are.
* [KextWizard](https://www.osx86.net/files/file/4304-kext-wizard-3711/) to install kexts easily without having to manually do it.
* Xcode for properly editing plist files. Clover config is known to cause problems according to RehabMan. As was proven to me when I was making patches for things.
* [GitBook Hackintosh Guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/) for explanations and details on each part of the process.
* [Clover Installer](https://bitbucket.org/RehabMan/clover/downloads/) RehabMan fork to make a generic EFI.
* [IOReg](https://www.tonymacx86.com/threads/guide-how-to-make-a-copy-of-ioreg.58368/) for USB patching. Already included in this repo.

# Kexts

Keep them updated!

* [AppleALC](https://github.com/acidanthera/AppleALC/releases)
    * Makes native audio work.
* [CodedCommander](https://bitbucket.org/RehabMan/os-x-eapd-codec-commander/downloads/)
    * Helps prevent audio breaking after sleep.
* [FakeSMC](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/)
    * Essential to make all this happen.
* [IntelMausiEthernet](https://bitbucket.org/RehabMan/os-x-intel-network/downloads/)
    * The LAN port on this board uses Intel
* [Lilu](https://github.com/acidanthera/Lilu/releases)
    * System patching plugin
* [USBInjectAll](https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/)
    * Make all the USB ports and hubs visible.
* [WhateverGreen](https://github.com/acidanthera/WhateverGreen/releases)
    * Graphics fixup plugin.
* [XHCI-Unsupported](https://github.com/RehabMan/OS-X-USB-Inject-All/archive/master.zip)
    * More USB support.

# Installation

Please read all of the instructions before you start installing! For the sake of avoiding confusion for myself and others, I made two EFI folders.

## BIOS

BIOS Page
* BIOS Features > Windows 8/10 Features > Other OS
* BIOS Features > Storage Boot Option Control > UEFI Only

Peripherals Page
* Initial Display Output > PCIe Slot
* Peripherals > XHCI Hand-off > Enable
* Network Stack > Wake on LAN > Disabled

Chipset Page
* VTd > Disabled
* Internal Graphics > Enabled > 128MB

My overclock is optional. The above BIOS settings are *required*.

* CPU upgrade 4.2GHz.
* Voltage 1.225
* LoadLine Calibration High.
* Memory XMP Profile 1.

## Pre-Install

* Create a vanilla installer and clone or download this repo.
    * `sudo /PathToApp/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/USBName`
* If you want iMessage, iCloud and FaceTime, edit the `post-config.plist` in SSD_EFI to fill in the blanks for `SMBIOS` !!
* Copy USB_EFI to mounted USB EFI partition.
* Compress SSD_EFI and copy to USB.
* Boot Install from USB.
* Format SSD as APFS.
* Start install as normal.
* At 72% / 2mins left, system will reboot.
* Boot from USB - *Preboot on drive_Name*. System will reboot shortly.
* Boot from USB - *Preboot on drive_Name*.
* Install will complete. Took 10 minutes for me.
* Boot from USB - Now you can choose *macOS on drive_Name*

## Post-Install

* Copy SSD_EFI.zip from USB to SSD and extract.
* The USB `config.plist` is only usable for booting the USB. You must instead use the `post-config.plist` to complete install.
* **Nvidia Only:** You need `EmuVariableUefi-64.efi` in Clover to make the GPU work. It's already there. Install the web drivers.
* **AMD Only:** Works out of box. You do need to remove Nvidia specifics from the config. Remove `nvda_drv=1` from Boot Arguments. Remove `NvidiaWeb=Yes` from System Parameters.
* Rename `post-config.plist` to `config.plist`.
* Copy SSD_EFI to mounted SSD EFI partition.
* Install required kexts using a kext installer like KextWizard or do it manually. The bare minimum will remain in Clover for Recovery. See folder Post_Install_Kexts. Don't forget to run Repair Permissions if using KextWizard.
* Install any additional required software now for devices. 
* Rebuild kext cache `sudo kextcache -i /`
* Shutdown. Do not restart.
* You can now boot from the SSD instead of the USB.
* **Nvidia only:** If the system booted without GPU acceleration, open System Preferences and change to use Nvidia Web Drivers and reboot.

## NVRAM

`AptioMemoryFix-64.efi` - `OsxAptioFixDrv-64.efi` - `OsxAptioFix2Drv-64.efi` - `OsxAptioFix3Drv-64.efi`

All of these do something a little different to enable NVRAM when not natively supported. I tried all of them and AptioMemoryFix works best. I did not get the *Recovered Files* folder in the trash upon reboot. The others led to faulty boots with a low resolution only to have the system grind to a halt mid boot and have to kill the power. OsxAptioFix2Drv was the one that did that every reboot. You can easily change which one you want to use after you have installed. Clear what's stored first, replace the efi and rebuild kextcache.

## Water Cooling

**Specific to my build:** Unfortunately it is impossible to control the pump speed with any OS other than Windows. As a result you must alter how the hardware is plugged in. You must make sure the radiator fans are plugged into a header that is PWM capable. For example my radiator fans are plugged into a splitter, and the splitter plugged into CPU_FAN. In BIOS fan control CPU_FAN is set to monitor CPU temp using a custom fan curve. The pump was plugged into SYS_PUMP and set to monitor CPU with the curve Full Speed; but I discovered I could get even better results by not plugging into any header . You do *need* to remove the USB plug from it. This means no lights (doesn't bother me). If you do not, it *will* run using Silent mode all the time. This results in very high temps; upwards of 80c. I use Intel Power Gadget to monitor hardware. But you can use the HWMonitor app that comes with the FakeSMC package. If you have a different brand AIO water cooler, you can try plugging it in the same way and see what you get. You'll need to tinker with your hardware first so you don't hit 100c during install where the CPU gets maxed out.

My radiator fan curve is as follows: (20c, 25%) (32c, 35%) (42c, 50%) (52c, 65%) (62c, 100%)

## IGPU Options

Hardware acceleration is enabled for IGPU 6600K while using dedicated graphics. If you have disabled IGPU in BIOS, you can turn it back on, set the size to 128mb and use PCI GPU as default. If you are using a 6700K you don't need to change the platform ID as they are the same. If you are using the 7th gen 7600K or 7700K the platform ID is `0x59120001`.

Not using dedicated a GPU? 6th gen is `0x19120000` and 7th gen is `0x59120000`. You do need to remove Nvidia specifics from the config. Remove `nvda_drv=1` from Boot Arguments. Remove `NvidiaWeb=Yes` from System Parameters. Under Graphics > Inject set Intel to NO. Under Devices > AddProperties set Item 0 to Disabled.

## USB Port Patching

Following this [guide by RehabMan](https://www.tonymacx86.com/threads/guide-creating-a-custom-ssdt-for-usbinjectall-kext.211311/) I created an SSDT to fix the USB port layout. The device ID for this board is `0xa2af`. You can try the one here, or make your own. Do keep in mind your port count may vary if you do not have the same hardware. Once created you can remove or disable the USB port limit patch from the config. Using Mojave? You need to use a [different patch](https://hackintosher.com/forums/thread/list-of-hackintosh-usb-port-limit-patches-10-14-updated.467/).

# Gaming

What little games that can run on Mac natively from Steam run very well. HITMAN, DiRT Rally, WoW, Smite, LoL, Euro Truck Sim 2, and more run at 60fps with settings maxed out. I can stream and not suffer from from performance loss. I did the first time around because my install was degraded due to constant fiddling. Using [Wine](http://wineskin.urgesoftware.com/tiki-index.php) I can run Platinum, Gold and Silver rated games with mostly no issues. I don't like vysnc turned on in game so I limit my frames to 75 or 60 depending on what the game settings allow. Considering my monitor is FreeSync and AMD is better supported in macOS, I need to get an RX580 or Vega. If you followed the guide an enabled QuickSync (hardware rendering) you can use [GameShow](http://www.gameshow.net) to strem and record your gameplay. If you want to use OBS, [here is a great video](https://www.youtube.com/watch?v=F2OzfwFHjhE). I could not get this program to use hardware accleration. It does work, but the quality meh.

# Temperatures

Idle for a few hours temps drop to 22c. Light use is around 30c. Gaming ranges from 40c to 60c. I ran a terminal test with `yes > /dev/null &`. After one hour average temp was 58.2c. Highest was 61.7c. Eliminating CAM and using BIOS results in consistent temps across all three operating systems.

# Brightness Control

If your monitor supports brightness control within Windows, as mine does, you can [control it in macOS](https://github.com/KAMIKAZEUA/NativeDisplayBrightness/releases). You can map the keys how you like using this app. However, Logitech G keys do not allow mapping past F12. You can use an LUA script to map it as you wish. I have a [G910](https://www.logitechg.com/en-us/products/gaming-keyboards/rgb-gaming-keyboard-g910.html). I forked an existing gist and modified it. Unassigned G6 and G7, then scripted G6 and G7 to be F18 and F19. The script will override what you set through the UI. If you do not unassign you will get the error tone when adjusting brightness. You can see that script here: https://gist.github.com/cbabb/85047be7ced0f789c3c7a5941603cd7a

# Audio Input/Output

Realtek ALC1220. AppleALC with an unmodified AppleHDA, using layout 11. Already set in config.

* Out: Digital Out, Internal Speakers, Line out 1, Line out 2.
* In: Internal mic, Line in
* USB: [Logitech C910 1080p HD Pro](https://www.newegg.com/Product/Product.aspx?Item=N82E16826104385), [KRAKEN 7.1](https://www.razer.com/gaming-audio/razer-kraken-71-v2)

Internal speakers is used when plugging into the rear (green) speaker jack. If you are a gamer, like myself, and do like to stream I have not ran into any problem using a USB headset with mic or the webcam. The only issue I have with audio is using Adobe programs. Audition will not properly work with USB mics. I have tried both of my devices and the program reports all audio as suddenly not working. Still looking into a fix for this.

If you do not like the sound of your audio (sounds flat) you can use [eqMac](https://bitgapp.com/eqmac/) or [Boom3D](https://www.globaldelight.com/boom/index.php). I use the latter.

# Back it up!

The most important part once satisfied with the install. Set up TimeMachine so if something goes wrong, you can recover. This also means don't erase your USB drive. I keep mine stored away just in case.

# Final notes

I installed macOS in late August. I had a mostly stable build while learning. The only thing I did that broke things was try to control fans with a program. Upon use, the fans kicked on high and attempting to adjust the speed instantly powered the machine off. Little bugs here and there prompted me to reinstall after learning a lot. I mainly made this for myself because I forget *a lot* of the stuff I do. Once I perfect something I like to know how I can repeat it. I have at this point, just one issue as metioned above. I managed to solve a lot otherwise. It's stable, cool and silent. I have Linux in the flavor of Ubuntu, and sadly a Windows 10 install. Games that just don't run on either *Nix platform, I have Windows; used sparingly. Sleep works nicely. I didn't include it in either config because I didn't want it to get forgotten about while setting up, and the system sleep only to bug out. Darkwake 8 or 9 works. Hibernate sort of works. Hit or miss. But I don't use hibernate at all. You can disable with `sudo pmset -a hibernatemode 0` and then `sudo rm /var/vm/sleepimage`.

[Need help?](https://www.reddit.com/message/compose/?to=cbabbx)

*[Back to top](#top)*
