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
    5. [IGPU Options](#igpu-options)
    6. [USB Port Patching](#usb-port-patching)
6. [Cooling & Temperatures](#cooling--temperatures)
7. [Gaming](#gaming)
8. [Brightness Control](#brightness-control)
9. [Audio Input/Output](#audio-inputoutput)
10. [Back it up!](#back-it-up)
11. [Final Notes](#final-notes)

# Hardware

[Picture](https://i.imgur.com/fAS78bK.jpg)

* Board: [Gigabyte Z270X Ultra Gaming](https://www.gigabyte.com/Motherboard/GA-Z270X-Ultra-Gaming-rev-10#kf)
* CPU: [Intel i5 6600K](https://ark.intel.com/products/88191/Intel-Core-i5-6600K-Processor-6M-Cache-up-to-3-90-GHz-) 3.5 Ghz (OC 4.4)
* Cooler: [Cryorig H7 Plus](http://www.cryorig.com/h7plus_us.php) (air)
* RAM: [G.Skill 16GB DDR4 2400](https://www.newegg.com/Product/Product.aspx?Item=N82E16820231888)
* GPU: [EVGA Nvidia 980Ti FTW](https://www.newegg.com/Product/Product.aspx?Item=9SIAE8D8HT3759)
* WiFi: [TP-Link Archer T9E](https://www.newegg.com/Product/Product.aspx?Item=33-704-241)
* SSD: [Samsung 850 Evo 250GB](https://www.newegg.com/Product/Product.aspx?Item=9SIA4P02S09329) & [Toshiba OCZ 240GB](https://www.newegg.com/Product/Product.aspx?Item=N82E16820168335)
* HDD: WD Blue [1TB](https://www.newegg.com/Product/Product.aspx?item=N82E16822235014) & [4TB](https://www.newegg.com/Product/Product.aspx?Item=N82E16822235011)
* HDD: WD Green [2TB](https://www.newegg.com/Product/Product.aspx?Item=9SIAAEE4F65325)
* Display: [Dell SE2717H/HX](https://www.newegg.com/Product/Product.aspx?Item=N82E16824260491)

# Supported Versions

![aboutMac](https://i.imgur.com/k9kDGeN.png)

High Sierra 10.13.6 (17G4015).

Currently, there is no web drivers for Nvidia in Mojave. You must use either use AMD or IGPU. AMD works out of the box with `Lilu` and `WhateverGreen` kexts found in this repo. IGPU requires booting with a fake ID at first until you generate kextcache with the proper platform ID for next boot. If Nvidia drivers for Mojave get released, I'll update this with a version for it.

# Tools and Sources

My first attempt from nothing involved [using a VM](https://techsviewer.com/install-macos-sierra-virtualbox-windows/) since I did not have access to a real Mac. It resulted in the first two USB creations to be slighly bugged. I tried the vanilla method and Unibeast. I found a patching app from [dosdude](http://dosdude1.com/highsierra/) that worked. It was enough to get me started, albiet not how I want. Making a USB install from a VM was a struggle, on top of only being able to use 1024x768 resolution due to VM limitations. Second hand older Macs can be found for cheap if you don't have famiy or friends that have one.

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
    * Helps prevent audio breaking after sleep. *(optional only if you use sleep)*
* [VirtualSMC](https://github.com/acidanthera/VirtualSMC/releases) or [FakeSMC](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/)
    * Essential to make all this happen. If you want hardware monitors use FakeSMC.
* [IntelMausiEthernet](https://bitbucket.org/RehabMan/os-x-intel-network/downloads/)
    * The LAN port on this board uses Intel
* [Lilu](https://github.com/acidanthera/Lilu/releases)
    * System patching plugin.
* [USBInjectAll](https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/)
    * Make all the USB ports and hubs visible.
* [WhateverGreen](https://github.com/acidanthera/WhateverGreen/releases)
    * Graphics fixup plugin.

# Installation

Please read all of the instructions before you start installing! For the sake of avoiding confusion for myself and others, I made two EFI folders.

The PCI wifi card I have is supported out of the box without any additional software, kexts, or modifications. It uses the BCM4360 chipset which has drivers already available in macOS.

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

* CPU upgrade 4.4GHz.
* Voltage 1.290
* LoadLine Calibration High.
* Memory XMP Profile 1.

## Pre-Install

* Create a vanilla installer and clone or download this repo.
    * `sudo /PathToApp/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/<USBName>`
* If you want iMessage, iCloud and FaceTime, edit the `post-config.plist` in SSD_EFI to fill in the blanks for `SMBIOS` !!
* Copy USB_EFI to mounted USB EFI partition.
* Compress SSD_EFI and copy to USB.
* Boot Install from USB.
* Format SSD as APFS.
* Start install as normal.
* At 72% / 2mins left, system will reboot.
* Boot from USB - *Preboot on <drive_Name>*. System will reboot shortly.
* Boot from USB - *Preboot on <drive_Name>*.
* Install will complete. Took 10 minutes for me.
* Boot from USB - Now you can choose *macOS on <drive_Name>*

## Post-Install

* Copy SSD_EFI.zip from USB to SSD and extract.
* The USB `config.plist` is only usable for booting the USB. You must instead use the `post-config.plist` to complete install.
* **Nvidia Only:** You need `EmuVariableUefi-64.efi` in Clover to make the GPU work. It's already there. Install the web drivers.
* **AMD Only:** Works out of box. You do need to remove Nvidia specifics from the config. Remove `nvda_drv=1` from Boot Arguments. Remove `NvidiaWeb=Yes` from System Parameters.
* Rename `post-config.plist` to `config.plist`.
* Copy SSD_EFI to mounted SSD EFI partition.
* Install required kexts using a kext installer like KextWizard or do it manually. Don't forget to run Repair Permissions if using KextWizard.
* Install any additional required software now for devices. 
* Rebuild kext cache `sudo kextcache -i /`
* Shutdown. Do not restart.
* You can now boot from the SSD instead of the USB.
* **Nvidia only:** If the system booted without GPU acceleration, open System Preferences and change to use Nvidia Web Drivers and reboot.

When there is a security update, DO NOT update the same day. Wait a few days to a week as there could be potential issues with kexts and drivers. Nvidia drivers come days after a patch.

## NVRAM

`AptioMemoryFix-64.efi` - `OsxAptioFixDrv-64.efi` - `OsxAptioFix2Drv-64.efi` - `OsxAptioFix3Drv-64.efi`

All of these do something a little different to enable NVRAM when not natively supported. I tried all of them and AptioMemoryFix works best. I did not get the *Recovered Files* folder in the trash upon reboot. The others led to faulty boots with a low resolution only to have the system grind to a halt mid boot and have to kill the power. OsxAptioFix2Drv was the one that did that every reboot. You can easily change which one you want to use after you have installed. Clear what's stored first, replace the efi and rebuild kextcache.

## IGPU Options

Hardware acceleration is enabled for IGPU 6600K while using dedicated graphics. If you have disabled IGPU in BIOS, you can turn it back on, set the size to 128mb and use PCI GPU as default. If you are using a 6700K you don't need to change the platform ID as they are the same. If you are using the 7th gen 7600K or 7700K the platform ID is `0x59120001`.

Not using dedicated a GPU? 6th gen is `0x19120000` and 7th gen is `0x59120000`. You do need to remove Nvidia specifics from the config. Remove `nvda_drv=1` from Boot Arguments. Remove `NvidiaWeb=Yes` from System Parameters. Under Graphics > Inject set Intel to NO. Under Devices > AddProperties set Item 0 to Disabled.

For browsers, hardware acceleration is preffered. Not only does this take a load of CPU cycles, it also saves battery for hackbooks. Unfortunately, Chrome, Opera and Vivaldi do not take advantage of it. They are all based on Chromium (Blink rendering) and suffer from the same issue. I tried multiple flags and settings to force it. Nothing worked. It still used software rendering. Safari does use hardware rendering, but cannot use Netflix or play any other form of DRM content. The Silverlight plugin for Safari was used to watch Netflix many years ago. MS killed it off and due to the security holes in it, Safari will not load the outdated plugin. Your best option for both DRM content and hardware rendering is to use Firefox.

## USB Port Patching

Following this [guide by RehabMan](https://www.tonymacx86.com/threads/guide-creating-a-custom-ssdt-for-usbinjectall-kext.211311/) I created an SSDT to fix the USB port layout. The device ID for this board is `0xa2af`. You can try the one here, or make your own. Do keep in mind your port count may vary if you do not have the same hardware. Once created you can remove or disable the USB port limit patch from the config. Using Mojave? You need to use a [different patch](https://hackintosher.com/forums/thread/list-of-hackintosh-usb-port-limit-patches-10-14-updated.467/).

# Cooling & Temperatures

Previously I used an NZXT X62. It is *impossible* to control the pump speed with any OS other than Windows. I no longer use Windows as my daily OS. As a result it ran in silent mode all the time and led to high temps. Unfortunately, the water cooler was not as reliable as I had hoped. Just under two years old the pcb board on the pump failed. Submitted a warranty claim and have since purchased an H7 Plus. It's ideal for multiple OS use and especially so since I have an overclock.

Idle for a few hours temps drop to 22c. Light use is around ~30c. Gaming ranges from 40c to 60c. I ran a terminal test with `yes > /dev/null &`. After one hour average temp was ~58c. Highest was ~62c. This was about the same for water cooling when it worked. Fan setup below.

* Exahust
    * Roof & Rear: [Corsair AF140](https://www.corsair.com/us/en/Categories/Products/Fans/Air-Series™-AF140-Quiet-Edition-High-Airflow-140mm-Fan/p/CO-9050009-WW) x3
* Intake
    * Front: [Fractal Design Venturi HP-14](http://www.fractal-design.com/home/product/casefans/venturi-series/venturi-hp-14-pwm) x2

Using the built-in SmartFan 5 features:
* CPU_FAN: Monitor CPU. Temp interval 3. Mode PWM.
* CPU_OPT: *unused*
* SYS_FAN1: Roof exhaust. Monitor board. Temp interval 2. Mode Voltage.
* SYS_FAN2: Front intake. Monitor CPU. Temp interval 3. Mode PWM.
* SYS_FAN3: Rear exhaust. Monitor CPU. Temp interval 3. Mode Voltage.

The fan curves are set so the front intake and rear exhaust line up nicely with the speed of the CPU fans. It lets the CPU get to about 45c before the curve gets steeper.
1. This is to ensure good airflow.
2. Less drag between fans.
3. Hot air won't get stuck and accumulate in the case.
4. Synced speeds means lower overall fan RPM to keep cool. AKA Quiet.

Heat from the GPU and the ambient heat from the board rise and are sucked out roof. These fans do increase as the ambient temp rises. They remain quiet and rarely exceed 50% of max RPM. Using Temp interval 2 and 3 functions like a hysteresis feature found in cooling software. When you open your browser, your CPU spikes 30c > 40c > 30c in a matter of a second. Using interval 1 means the fans act aggresive in response to rising temps. It fluctuates the fan speed in real time. This can get annoying hearing the fans go *hmmm* > *WHIRRRR* > *hmmm* over and over. Setting it to 2 creates a gap or delay in response. If sustained at a certain temp for a time, the fans will pick up speed. Setting it to 3 further increases that gap or delay. This setting is mostly preference. But we all like a quiet computer!

TIP: HWMonitor doesn't label fans. You can easily change that. Open `/Applications/HWMonitor.app/Contents/Resources/en.lproj/Localizable.strings` in xcode editor. Change the names accordingly. Here's mine:

* "MB Fan 0" = "CPU_FAN";
* "MB Fan 1" = "SYS_FAN1 Roof";
* "MB Fan 2" = "SYS_FAN2 Front";
* "MB Fan 3" = "SYS_FAN3 Rear";

![hwmonitor](https://i.imgur.com/NiEBojN.png)

# Gaming

What little games that can run on Mac natively from Steam run very well. HITMAN, DiRT Rally, WoW, Smite, LoL, Euro Truck Sim 2, and a few more run at 60fps with settings maxed out. I can stream and not suffer from from performance loss. I did the first time around because my install was degraded due to constant fiddling. Using [Wine](http://wineskin.urgesoftware.com/tiki-index.php) I can run Platinum, Gold and Silver rated games with mostly no issues. I don't like vysnc turned on in game so I limit my frames to 75 or 60 depending on what the game settings allow. Considering my monitor is FreeSync and AMD is better supported in macOS, I need to get an RX580 or Vega. If you followed the guide an enabled QuickSync (hardware rendering) you can use [Wirecast](https://www.telestream.net/wirecast/) to stream and record your gameplay. [Gameshow](http://www.gameshow.net) was the suggested software to use but it has since been killed off and is no longer for sale. If you want to use OBS, [here is a great video](https://www.youtube.com/watch?v=F2OzfwFHjhE). I could not get this program to use hardware accleration. It does work, but the quality is meh and it can consume too much CPU.

# Brightness Control

If your monitor supports brightness control within Windows, as mine does, you can [control it in macOS](https://github.com/KAMIKAZEUA/NativeDisplayBrightness/releases). You can map the keys how you like using this app. However, Logitech G keys do not allow mapping past F12. You can use an LUA script to map it as you wish. I have a [G910](https://www.logitechg.com/en-us/products/gaming-keyboards/rgb-gaming-keyboard-g910.html). I forked an existing gist and modified it. Unassigned G6 and G7, then scripted G6 and G7 to be F18 and F19. The script will override what you set through the UI. If you do not unassign you will get the error tone when adjusting brightness. You can see that script here: https://gist.github.com/icedterminal/85047be7ced0f789c3c7a5941603cd7a

![status bar](https://i.imgur.com/GPTe0Le.jpg)

# Audio Input/Output

Realtek ALC1220. AppleALC with an unmodified AppleHDA, using layout 11. Already set in config.

* Out: Digital Out, Internal Speakers, Line out 1, Line out 2.
* In: Internal mic, Line in
* USB: [Logitech C910 1080p HD Pro](https://www.newegg.com/Product/Product.aspx?Item=N82E16826104385), [KRAKEN 7.1](https://www.razer.com/gaming-audio/razer-kraken-71-v2)

Internal speakers is used when plugging into the rear (green) speaker jack. If you are a gamer, like myself, and do like to stream I have not ran into any problem using a USB headset with mic or the webcam. The only issue I have with audio is using Adobe programs. Audition will not properly work with USB mics. I have tried both of my devices and the program reports all audio as suddenly not working. Still looking into a fix for this.

If you do not like the sound of your audio (sounds flat) you can use [eqMac](https://bitgapp.com/eqmac/), [Boom3D or Boom2](https://www.globaldelight.com/store). I use the latter, Boom2.

**Update:**
I *think* I have found a solution for the audio hardware issue in Adobe programs. Both my headset and webcam/mic are USB devices and that's the cause of the hardware bugging out. If I use a mic that uses the dedicated jack on the computer I do not have this problem. For whatever reason I thought I would try using a different audio layout. I changed from `11` to `1`, rebuilt kextcache and rebooted. No dice. I did noticed that with a `1` the volume was muted every reboot. I changed it back `11`, rebuilt kextcache and rebooted. To my surprise it appears to have worked. I don't get the warning audio hardware is not responding.

![boom2](https://i.imgur.com/zGeVWTn.png)

# Back it up!

The most important part once satisfied with the install. Set up TimeMachine so if something goes wrong, you can recover. This also means **don't** erase your USB drive. I keep mine stored away just in case. If you don't have enough, you can pick one up from Newegg, Amazon or BestBuy for less than $10.

# Final notes

I installed macOS in late August. I had a mostly stable build while learning. The only thing I did that broke things was try to control fans with a program. Upon use, the fans kicked on high and attempting to adjust the speed instantly powered the machine off. Little bugs here and there prompted me to reinstall after learning a lot. I mainly made this for myself because I forget *a lot* of the stuff I do. Once I perfect something I like to know how I can repeat it. I have at this point, just one issue as metioned above. I managed to solve a lot otherwise. It's stable, cool and silent. I have Linux in the flavor of Ubuntu, and sadly a Windows 10 install sharing the other SSD. Games that just don't run on either *Nix platform, I have Windows; used sparingly. Sleep works nicely. I didn't include it in either config because I didn't want it to get forgotten about while setting up, and the system sleep only to bug out. Darkwake 8 or 9 works. Hibernate sort of works. Hit or miss. But I don't use hibernate at all. You can disable with `sudo pmset -a hibernatemode 0` and then `sudo rm /var/vm/sleepimage`.

Need help? [Twitter](https://twitter.com/icedterminal) | [electronic mail](mailto:icedterminal@gmail.com)

*[Back to top](#top)*
