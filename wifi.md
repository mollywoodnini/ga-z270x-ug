# Renaming ACPI WiFi

![ioreg screenshot](https://i.imgur.com/9kMxG2A.png)

The image above is the final result. You can see the other ACPI devices are PXSX while only the WiFi card is ARPT.

1. Open your config file and navigate to ACPI > DSDT > Fixes. Add a new *Boolean* item named `AddDTGP`. Set value to YES. This is important! This enables the renaming facility.
2. Navigate to ACPI > RenameDevices. If you do not already have this, simply add a new *Dictionary* item, then add a new *String* item.
    * The name of this string will be pulled from IOReg. You will be looking for *acpi-path* in the *Property* column. It will look something like this: `IOACPIPlane:/_SB/PCI0@0/RP03@1c0002/PXSX@0`
    * You can click the *Value* to copy the text.
    * Paste that into the config replacing the *New item* text. You need to trim down the excess.
    * `IOACPIPlane:/_SB/PCI0@0/RP03@1c0002/PXSX@0` will be edited to `_SB.PCI0.RP03.PXSX`
    * The value of this string will be what we want `PXSX` to called. In this case, `ARPT`.
3. Save the config, rebuild kext cache and reboot.

# WiFi Crashes and Micro Stutter

![crash log](https://i.imgur.com/uM6qL1l.png)

This directory shows my brand new wifi card is crashing consistently.

What is Micro stutter? Every so often the frames stop for milliseconds, then resume. This is really annoying while gaming. My first reaction was driver issues. I went through and patched every driver version of Nvidia all the way back to `.105`. Didn't make a difference. The stutter is present in Windows where TP-Link offers support. I ran a diagnostics and 50% through the test, macOS suddenly reboots. I found a guide detailing all the logging locations which is the screenshot above.

I've tried:
* Changing wifi channels
* Adjusting antennas
* Move USB 3 BT to top of case
* Checking area signals
* Resetting wifi/network settings
* Change PCI x1 from slot 3 to 1. (Which is above the gpu, under the heatsink.)

There were two more crashes with the driver in a different slot. I did a lot of reading to learn some more about the ACPI section of the config. I had many redundant fixes that were already covered elsewhere. Last month I tried getting a PCE-AC88 working. From that trial, Wifi cards are actually under `ARPT` and not `PXSX`. RehabMan says it shouldn't be necessary to rename, however macOS wifi is different. And on a different forum a well-educated user said macOS expects or is looking for that. In efforts to rule out that issue, I added a RenameDevice entry. Which is the reason for the guide at the top.

A user on reddit posted a link to Intel USB 3 interference. https://www.intel.com/content/www/us/en/io/universal-serial-bus/usb3-frequency-interference-paper.html – Provides useful information, however, the rear of my computer has only two USB 2 ports occupied with a mouse and keyboard. I doubted that was cause.

On the morning of 15th of Feb, I made a lot of changes. I had already added a rename device entry. So I took it a step further.

* Updated ApfsDriverLoader-64.efi and AptioMemoryFix.efi from the official repos.
* Added RTCMemoryFixup.kext
* Re-enabled FixHeaders
* Removed redundant fixes from config
* Cleared nvram
* Reset BIOS
* Cleared CMOS
* Rebuilt kextcache

So far it appears to have worked. I have not had a crash yet. The stutter is still present.

17th of Feb: *Sigh* – And it crashed. I traced it back to FakeSMC sensors. So they had to go. We'll see it how that goes. There are no issues on Windows at the moment.
