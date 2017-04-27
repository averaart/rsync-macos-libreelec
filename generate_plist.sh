#!/usr/bin/env bash
# Accepts two arguments: source directory and destination including user@host.
from=$1
to=$2
label=$(echo $1 | sed 's/[^A-Za-z0-9]//g')
plist="nl.andra.rsync-to-kodi.$label.plist"
cat << EOF > $plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
		<string>nl.andra.rsync-to-kodi.$label</string>
	<key>ProgramArguments</key>
	<array>
		<string>/Library/Application Support/nl.andra.rsync-to-kodi/LaunchDaemons/sync_to_libreelec.sh</string>
		<string>$from/</string>
		<string>$to</string>
	</array>
	<!-- Uncomment these lines to enable logging
	<key>StandardErrorPath</key>
		<string>/Library/Application Support/nl.andra.rsync-to-kodi/$label.stderr</string>
	<key>StandardOutPath</key>
		<string>/Library/Application Support/nl.andra.rsync-to-kodi/$label.stdout</string>
	-->
	<key>WatchPaths</key>
	<array>
		<string>$from</string>
	</array>
</dict>
</plist>
EOF
