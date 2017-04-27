#!/usr/bin/env bash
# Accepts two arguments: source directory and destination including user@host.
destination=$(printf %q $2)
/usr/local/bin/sshpass -f "/Library/Application Support/nl.andra.rsync-to-kodi/LaunchDaemons/libreelec-password.txt" \
  /usr/bin/rsync -aP --delete \
                 --exclude-from="/Library/Application Support/nl.andra.rsync-to-kodi/LaunchDaemons/rsync-excludes.txt" \
                 --rsync-path=/storage/.kodi/addons/virtual.network-tools/bin/rsync $1 $destination
