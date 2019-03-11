#!/bin/bash
# create settings file
cat > liquidctlSettings.sh << EOF
#!/bin/bash
# set fans in 7 steps
liquidctl set fan speed 25 35  30 45  35 60  40 70  45 80  50 90  60 100
# set pump in 7 steps
liquidctl set pump speed 25 60  30 65  35 70  40 80  45 90  50 90  60 100
# set lights
liquidctl set logo color fixed ffffff
liquidctl set ring color fixed ffffff
EOF
# make executable
chmod +x liquidctlSettings.sh
# hide it?
#chflags hidden liquidctlSettings.sh
# create automated file
cat > ~/Library/LaunchAgents/com.jonasmalacofilho.liquidctl.plist << EOF
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
		<string>~/liquidctlSettings.sh</string>
	</array>
	<key>Label</key>
	<string>com.jonasmalacofilho.liquidctl</string>
	<key>RunAtLoad</key>
	<true/>
	<key>KeepAlive</key>
	<false/>
</dict>
</plist>
EOF
# add to user startup
launchctl load ~/Library/LaunchAgents/com.jonasmalacofilho.liquidctl.plist