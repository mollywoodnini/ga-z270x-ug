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
