As it currently stands, OpenCore is future of hackintosh going forward. However, Clover offers more stability. If you wish to install macOS without fear of boot troubles, you should remain on Clover.

Clover: Please [follow the guide here](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/) if you need details or information explaining the sections of the config. These configs are unchanged since I last used them. I have had zero complications or instability. I have left them available as a reference for this motherboard. You can esentially drop in place and go.

OpenCore: ~~I have not had any issues thus far.~~ If you want to take a dive, go for it. The guide for [OpenCore can be found here](https://dortania.github.io/OpenCore-Desktop-Guide/).

Currently two issues are present. 

1. CPU idles down to 1.8GHz. Will not drop to 800MHz. As it does with Clover as the bootloader and Windows.
2. PowerNap, Sleep and Hibernate do not function. System goes for this power state and hangs. Powered on but in a frozen state. Does not respond to input. Screen is black.

## Debug Branch

This branch has all logging turned on. It is slower to boot. This branch is where I will be keeping all testing done so as to not interfere with the master branch in case I screw up. 

---

See WIKI for additional information.
