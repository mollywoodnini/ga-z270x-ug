#!/bin/bash
(( EUID != 0 )) && exec sudo -- "$0" "$@"
echo "All network interfaces will be removed!"
echo "All network preferences will be reset!"
echo "Once completed, the computer will restart."
read -p "Press enter to continue..."
# Reset Network
rm /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist
rm /Library/Preferences/SystemConfiguration/com.apple.network.eapolclient.configuration.plist
rm /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist
rm /Library/Preferences/SystemConfiguration/com.apple.wifi.message-tracer.plist
rm /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
rm /Library/Preferences/SystemConfiguration/preferences.plist
shutdown -r now
