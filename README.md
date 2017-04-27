rsync files from macOS to Kodi running on LibreELEC
===================================================

Here's my attempt at synchronising a set of folders from my macOS (formerly OS X)
machine to a [Raspberry Pi 3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
running [Kodi](https://kodi.tv) on [LibreELEC](https://libreelec.tv).

The aim here is to keep Kodi up to date with family photos and videos. So
whenever I download media from our various devices into a particular set of
directories, these directories should be synchronised to the Pi.

I'll try to keep things as general as possible, using `.gitignore`d files for
actual folder names and other configuration.

## Goals

- One directional sync: from macOS to LibreELEC
- Synchronise on change

## Instructions

### On Kodi / LibreELEC

1. Install LibreELEC Network Tools add-on to add `rsync`
  1. System
  2. Settings
  3. Add-ons
  4. Install from repository
  5. LibreELEC Add-ons
  6. Program add-ons
  7. Network Tools
  8. Install

### On macOS

1. Install [homebrew]
2. Install `sshpass`
  1. run `brew install sshpass`
  2. Read the warning!
    - `We won't add sshpass because it makes it too easy for novice SSH users to ruin SSH's security.`
  3. Meditate on the warning
  4. Lookup the latest version of `sshpass`
    - `latest_sshpass_version=$(curl -ILs -o /dev/null -w %{url_effective} https://sourceforge.net/projects/sshpass/files/latest/download?source=files)`
    - [source][get_redirect_url]
  5. Optionally, if you're not familiar/comfortable with `vim`, set your favourite editor in your `EDITOR` environment variable
    - e.g. `export EDITOR=atom`
  6. Create your very own Homebrew formula
    - `brew create $latest_sshpass_version --force` ([source][create_formula])
    - change `desc ""` into `desc "sshpass"`
    - change `homepage ""` into `homepage "https://sourceforge.net/projects/sshpass/"`
    - save the contents of the editor and close it
  7. run `brew install sshpass`
3. Clone this repository (if you haven't already)
4. cd into this repository
  - `cd rsync-macos-osx-libreelec-kodi`
5. Create your own copy of the password file used by `sshpass`
  - `cp LaunchDaemons/libreelec-password.example.txt LaunchDaemons/libreelec-password.txt`
  - Update the actual password in the file
6. Create symlink from Application Support to this repository
  - `sudo ln -s "$(pwd)" "/Library/Application Support/nl.andra.rsync-to-kodi"`
7. Add the Raspberry Pi to the known hosts for `root`
  - `sudo ssh root@<RASPBERRY-PI-IP>`

[homebrew]:             https://brew.sh
[get_redirect_url]:     http://stackoverflow.com/a/3077316
[create_formula]:       https://gist.github.com/arunoda/7790979#gistcomment-1756013
