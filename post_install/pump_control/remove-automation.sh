
#!/bin/bash
# This script will remove the automation process of python program liquidctl on macOS.
# Make this file executable by opening terminal and typing: chmod +x /path/to/remove-automation.sh
# Now you can run this script to remove automation.
# If you recieve the message: "Could not find specified service" that means it was already unloaded.
# No need to worry.

# We need super user (root) access to delete from /Library.
# If not or can't be given, removal can't complete.
(( EUID != 0 )) && exec sudo -- "$0" "$@"

echo "Remove from startup"
launchctl unload /Library/LaunchDaemons/liquidctl.plist
echo "Delete settings file"
rm -f /usr/local/share/LiquidCfg.sh
rm -f ~/Documents/Edit\ liquidctl
echo "Delete startup file"
rm -f /Library/LaunchDaemons/liquidctl.plist
echo "Removal complete!"
