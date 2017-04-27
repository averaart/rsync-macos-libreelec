#!/usr/bin/env bash
# Accepts two arguments: source directory and destination including user@host.
destination=$(printf %q $2)
sshpass -f libreelec-password.txt rsync -aP --delete --exclude-from=rsync-excludes.txt --rsync-path=/storage/.kodi/addons/virtual.network-tools/bin/rsync $1 $destination
