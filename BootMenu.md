# Clean Up Boot Menu

When formatting disks using the GPT partition scheme, macOS likes to create EFI partitions. If this isn't a boot disk you can get rid of it. Windows does not do this by default. You must create them or they are created by the installer on the destination disk. If you plan to use ExFAT, format with Windows if you can.

MBR only works with disks up to 2 TB and limits you to 4 Primary Partitions. So larger disks like my 4TB must use GPT. As a result I have a `P0: WD4XXXX` in my boot menu. I can disable boot entries but when I do I am left with empty choices on the boot screen. To get rid of them I need to remove the EFI partitions. I already did my large drive, so I'm using another drive as an example.

**Please pay careful attention to your numbers as there is no undo!**

* Open terminal and type in `diskutil list`
* You'll see a full list of your drives. If you have an APFS SSD there is an extra entry, take note.

```
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *250.1 GB   disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:                 Apple_APFS Container disk3         249.8 GB   disk0s2

/dev/disk3 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +249.8 GB   disk3
                                 Physical Store disk0s2
   1:                APFS Volume MacSSD                  140.9 GB   disk3s1
   2:                APFS Volume Preboot                 20.4 MB    disk3s2
   3:                APFS Volume Recovery                514.9 MB   disk3s3
   4:                APFS Volume VM
```

As you can see APFS is a container so Disk 3 is actually Disk 0. They are the technically the **same disk** and should be left alone.

* Using the list find the label of the mounted partition you want to edit.

```
/dev/disk4 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *500.1 GB   disk4
   1:                        EFI EFI                     209.1 MB   disk4s1
   2:                  Apple_HFS TimeMachine             499.8 GB   disk4s2
```

* This is the disk I want to remove the EFI from. Disk 4 named "TimeMachine"
* In terminal do the following:
    * `diskutil unmountDisk /dev/disk4`
    * `sudo gpt remove -i 1 disk4`
* This will remove the EFI partition that is numbered 1 and then remount the drive.

I rebooted and checked my entries and both empty spaces were now gone. If this didn't work for you, you can reset your BIOS firmware as the entries are cached in some way.
