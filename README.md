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

So there are some hoops to jump through to get this working, but I've tried to be
as complete as possible in my descriptions. Hopefully, this means I don't have to
rediscover everything if and when I ever decide to add more directories or even
change machines.

### On Kodi / LibreELEC

Install LibreELEC Network Tools add-on to add `rsync`. Just navigate through the
following menu items:

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
   - `sudo ln -s "$(pwd)" "/Library/Application Support/nl.andra.rsync-to-kodi"` ([source][symlink_current])
7. Add the Raspberry Pi to the known hosts for `root`
   - `sudo ssh root@<RASPBERRY-PI-IP>`
8. For each directory you wish to Synchronise, generate a .plist file
   - `./generate_plist.sh "/path/to/source/directory" "root@<RASPBERRY-PI-IP>:/path/to/destination/directory/"`
9. Symlink all generated .plist files to the `/Library/LaunchDaemons/` directory
   - `sudo ln -s $(pwd)/nl.andra.rsync-to-kodi.*.plist /Library/LaunchDaemons/` ([source][symlink_multiple])
10. Set the ownership of the generated .plist files to `root:wheel`
    - `sudo chown root:wheel /Library/LaunchDaemons/nl.andra.rsync-to-kodi.*.plist`

[homebrew]:             https://brew.sh
[get_redirect_url]:     http://stackoverflow.com/a/3077316
[create_formula]:       https://gist.github.com/arunoda/7790979#gistcomment-1756013
[symlink_current]:      https://unix.stackexchange.com/a/147796
[symlink_multiple]:     https://superuser.com/a/633610


## Notes

So why the hell did I tell you to install `homebrew` if I only use it to install
one tool that's not even really supported _by_ `homebrew`? Well, mostly because
I use homebrew for all my tools and try to avoid installing one-offs to keep things
nice and predictable.
