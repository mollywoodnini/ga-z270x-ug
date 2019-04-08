#!/bin/bash
# We need super user (root) access to write to /Library. If not or can't be given, setup can't complete.
(( EUID != 0 )) && exec sudo -- "$0" "$@"

# Check for the existance of Python 3.
if [ -d /Library/Frameworks/Python.framework/Versions/3.7 ]; then
[ "$(ls -A /Library/Frameworks/Python.framework/Versions/3.7)" ] && echo "Python 3 is installed"
else
 echo "Error: Python 3 is not installed. Setup cannot complete!" && exit
fi

echo "Create settings file at /usr/share/LiquidCfg.sh."

# Create settings file in an open directory available to everyone and system.
cat > /usr/share/LiquidCfg.sh << EOF
#!/bin/bash
# Location: /usr/share/LiquidCfg.sh
# You can use this file to modify how the liquidctl will configre devices upon startup.
# Kraken defaults to liquid temperature. These settings reflect those based off defaults from CAM.
# The lines below are examples of controlling the Kraken X series. If you have more devices see the README files from GitHub

liquidctl set fan speed 25 35  30 45  35 60  40 70  45 80  50 90  60 100 -d 0
liquidctl set pump speed 20 60  35 100 -d 0
liquidctl set logo color fixed 0000ff -d 0
liquidctl set ring color fixed 0000ff -d 0

EOF

echo "Make Settings file executable and editable."

# Make executable and editable otherwise it is locked due to elevated terminal creating it.
chmod 777 /usr/share/LiquidCfg.sh

echo "Create startup file at /Library/LaunchDaemons."

# Create automated file.
# Defined to run at load of system through the use of LaunchDaemon.
# As such it is not user dependent.
# launchd will not keep task alive. If it fails, it just fails. See Console system.log.
cat > /Library/LaunchDaemons/liquidctl.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>EnvironmentVariables</key>
	<dict>
		<key>PATH</key>
		<string>/Library/Frameworks/Python.framework/Versions/3.7/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
	</dict>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/share/LiquidCfg.sh</string>
	</array>
	<key>Label</key>
	<string>liquidctl</string>
	<key>RunAtLoad</key>
	<true/>
	<key>KeepAlive</key>
	<false/>
</dict>
</plist>
EOF

echo "Add to system startup."

# add to startup
launchctl load /Library/LaunchDaemons/liquidctl.plist

# run script to indicate success
/usr/local/share/LiquidCfg.sh

echo "Setup complete!"

# Open settings file for user to edit
open -a "TextEdit" /usr/share/LiquidCfg.sh
