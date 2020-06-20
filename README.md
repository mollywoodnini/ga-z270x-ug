The guide for OpenCore can be [found here](https://dortania.github.io/OpenCore-Desktop-Guide/).

Currently two issues are present. 

1. CPU idles down to 1.8GHz. Will not drop to 800MHz.
2. PowerNap, Sleep and Hibernate do not function. System goes for this power state and hangs. Powered on but in a frozen state. Does not respond to input. Screen is black.

## Z270 Series

Device | UD3 | UD5 | G5 | G7 | G8 | G9 | GK3 | GK5 | GK7 | UG 
-- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --
HDMI | Yes | Yes | Yes | Yes | Yes | Yes | Yes | Yes | Yes | Yes
DisplayPort | No | Yes | Yes | Yes | Yes | Yes | No | Yes | Yes | No 
ThunderBolt | No | Yes | No | Yes | Yes | Yes | No | No | No | No
Audio | ALC1220 | ALC1220 | ALC1220 | Creative 3D | Creative 3D | Creative 3D | ALC1220 | ACL1220 | ALC1220 | ACL1220
LAN | Intel | Intel | Intel & Killer | Intel & Killer | Intel & Killer | Killer | Killer | Killer | Intel & Killer | Intel
WiFi | No | No | No | No | Killer | Killer | No | No | No | No
I/O Chipset | ITE | ITE | ITE | ITE | ITE | ITE | ITE | ITE | ITE | ITE

- [Z270X UD3](https://www.gigabyte.com/us/Motherboard/GA-Z270X-UD3-rev-10/sp#sp)
- [Z270X UD5](https://www.gigabyte.com/us/Motherboard/GA-Z270X-UD5-rev-10/sp#sp)
- [Z270X Gaming 5](https://www.gigabyte.com/us/Motherboard/GA-Z270X-Gaming-5-rev-10/sp#sp)
- [Z270X Gaming 7](https://www.gigabyte.com/us/Motherboard/GA-Z270X-Gaming-7-rev-10/sp#sp)
- [Z270X Gaming 8](https://www.gigabyte.com/us/Motherboard/GA-Z270X-Gaming-8-rev-10/sp#sp)
- [Z270X Gaming 9](https://www.gigabyte.com/us/Motherboard/GA-Z270X-Gaming-9-rev-10/sp#sp)
- [Z270 Gaming K3](https://www.gigabyte.com/us/Motherboard/GA-Z270-Gaming-K3-rev-10/sp#sp)
- [Z270X Gaming K5](https://www.gigabyte.com/us/Motherboard/GA-Z270X-Gaming-K5-rev-10/sp#sp)
- [Z270X Gaming K7](https://www.gigabyte.com/us/Motherboard/GA-Z270X-Gaming-K7-rev-10/sp#sp)

Using this EFI as a reference will work for most of the boards in this lineup. You cannot use it as reference for Gaming 7, 8 and 9. Gigabyte tends to design their boards the same way so the firmwares are really similar. However, some of these are not the best choice and will leave you with devices that do not work. Boards with Creative Audio and Killer WiFi should be avoided. Killer LAN is supported. 

## Debug Branch

This branch has all logging turned on. It is slower to boot. This branch is where I will be keeping all testing done so as to not interfere with the master branch in case I screw up.

---

See WIKI for additional information.
