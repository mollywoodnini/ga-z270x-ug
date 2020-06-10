# Debug

This branch has all loggin turned on. It is slower to boot. This branch is where I will be keeping all testing done so as to not interfere with the master branch in case I screw up.

As it currently stands, OpenCore is future of hackintosh going forward. However, Clover offers more stability. If you wish to install macOS without fear of boot troubles, you should remain on Clover.

Clover: Please [follow the guide here](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/) if you need details or information explaining the sections of the config. These configs are unchanged since I last used them. I have had zero complications or instability. I have left them available as a reference for this motherboard. You can esentially drop in place and go.

OpenCore: ~~I have not had any issues thus far.~~ If you want to take a dive, go for it. The guide for [OpenCore can be found here](https://dortania.github.io/OpenCore-Desktop-Guide/).

Currently two issues are present. 

1. CPU idles down to 1.8GHz. Will not drop to 800MHz. As it does with Clover as the bootloader and Windows.
2. PowerNap, Sleep and Hibernate do not function. System goes for this power state and hangs. Powered on but in a frozen state. Does not respond to input. Screen is black.

# ACPI Issues

These are the ACPI tables detected in OC 0.6.0.
```
01:334 00:008 OCA: Found 21 ACPI tables
01:343 00:009 OCA: Detected table 50434146 (00002049204D2041) at 861359A8 of 276 bytes at index 0
01:355 00:012 OCA: Detected table 43495041 (00002049204D2041) at 86135AC0 of 132 bytes at index 1
01:369 00:013 OCA: Detected table 54445046 (00002049204D2041) at 86135B48 of 68 bytes at index 2
01:381 00:012 OCA: Detected table 4746434D (00002049204D2041) at 86135B90 of 60 bytes at index 3
01:394 00:012 OCA: Detected table 54445353 (6C62615461746153) at 86135BD0 of 956 bytes at index 4
01:406 00:012 OCA: Detected table 54444946 (00000049204D2041) at 86135F90 of 156 bytes at index 5
01:419 00:012 OCA: Detected table 54445353 (0020746473536153) at 86136030 of 12633 bytes at index 6
01:431 00:012 OCA: Detected table 54445353 (0074647353676550) at 86139190 of 9567 bytes at index 7
01:444 00:012 OCA: Detected table 54455048 (00000000004C4B53) at 8613B6F0 of 56 bytes at index 8
01:457 00:012 OCA: Detected table 54445353 (7076525F72656854) at 8613B728 of 3557 bytes at index 9
01:469 00:012 OCA: Detected table 54445353 (30317076725F6878) at 8613C510 of 10967 bytes at index 10
01:482 00:012 OCA: Detected table 49464555 (20202020324B4445) at 8613EFE8 of 66 bytes at index 11
01:495 00:012 OCA: Detected table 54445353 (0074647353757043) at 8613F030 of 3806 bytes at index 12
01:508 00:012 OCA: Detected table 5449504C (00000000004C4B53) at 8613FF10 of 148 bytes at index 13
01:521 00:013 OCA: Detected table 544D5357 (00000000004C4B53) at 8613FFA8 of 40 bytes at index 14
01:534 00:012 OCA: Detected table 54445353 (62756872736E6573) at 8613FFD0 of 671 bytes at index 15
01:547 00:012 OCA: Detected table 54445353 (6376654464697450) at 86140270 of 12290 bytes at index 16
01:560 00:012 OCA: Detected table 50474244 (0000000000000000) at 86143278 of 52 bytes at index 17
01:573 00:013 OCA: Detected table 32474244 (0000000000000000) at 861432B0 of 84 bytes at index 18
01:585 00:012 OCA: Detected table 54434656 (00002049204D2041) at 86143308 of 59524 bytes at index 19
01:598 00:012 OCA: Detected table 52414D44 (00000000204C4B53) at 86151B90 of 168 bytes at index 20
```
There are a total of 32 tables I can dump from firmware. It manages to detect all of the core SSDT files. Being named SSDT-0 through SSDT-7. Of those, SSDT-5 is the core CPU power table. It calls/is linked to 7 sub tables. SSDT-5_0 through SSDT-5_6. Clover detects these tables and I can drop them. Removing these tables results in proper power management. Otherwise you get a high idle speed (1.8GHz+) and weird usage spiking.

If these tables remain in OC, I get high idle speed. If I drop the only table I can, CpuSsdt, high idle remains and I get the idle usage spiking.

These are the tables I add to the ACPI Delete section of the config:

- CpuSsdt
- Cpu0Ist
- Cpu0Cst
- Cpu0Hwp
- ApHwp
- ApCst
- ApIst
- HwpLvt
- WSMT
- DBGP
- DBG2

And here is where the log reports failures.
```
02:700 00:017 OC: Failed to drop ACPI 54445353 0000006D50757043 0 (0) - Not Found
02:716 00:015 OC: Failed to drop ACPI 54445353 0074734930757043 0 (0) - Not Found
02:732 00:016 OC: Failed to drop ACPI 54445353 0074734330757043 0 (0) - Not Found
02:748 00:015 OC: Failed to drop ACPI 54445353 0070774830757043 0 (0) - Not Found
02:764 00:015 OC: Failed to drop ACPI 54445353 0000007077487041 0 (0) - Not Found
02:781 00:016 OC: Failed to drop ACPI 54445353 0000007473437041 0 (0) - Not Found
02:797 00:015 OC: Failed to drop ACPI 54445353 0000007473497041 0 (0) - Not Found
02:813 00:016 OC: Failed to drop ACPI 54445353 000074764C707748 0 (0) - Not Found
02:829 00:016 OCA: Deleting table 544D5357 (00000000004C4B53) of 40 bytes with 00000000004C4B53 ID at index 14
02:846 00:017 OCA: Deleting table 50474244 (0000000000000000) of 52 bytes with 0000000000000000 ID at index 16
02:864 00:017 OCA: Deleting table 32474244 (0000000000000000) of 84 bytes with 0000000000000000 ID at index 16
```
It drops both Windows Debug tables (DBGP, DBG2) and Windows security table (WSMT). But fails to drop all of the power related CPU tables. It doesn't detect them.

Reference table
```
50434146 <> 46414350 = FACP
43495041 <> 41504943 = APIC
54445046 <> 46504454 = FPDT
4746434D <> 4D434647 = MCFG
54445353 <> 53534454 = SSDT | 0074734930757043 <> 4370753049737400 = Cpu0Ist
54444946 <> 46494454 = FIDT
54445353 <> 53534454 = SSDT
54445353 <> 53534454 = SSDT
54455048 <> 48504554 = HPET
54445353 <> 53534454 = SSDT
54445353 <> 53534454 = SSDT
49464555 <> 55454649 = UEFI
54445353 <> 53534454 = SSDT
5449504C <> 4C504954 = LPIT
544D5357 <> 57534D54 = WSMT | 00000000004C4B53 <> 534B4C0000000000 = WSMT
54445353 <> 53534454 = SSDT
54445353 <> 53534454 = SSDT
50474244 <> 44424750 = DBGP | 0000000000000000 = DBGP
32474244 <> 44424732 = DBG2 | 0000000000000000 = DBG2
54434656 <> 56464354 = VFCT
52414D44 <> 444D4152 = DMAR | 00000000204C4B53 <> 534B4C2000000000  = DMAR
```
---

See WIKI for additional information.
