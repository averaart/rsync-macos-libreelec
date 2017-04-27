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

1. Install LibreELEC Network Tools add-on to add `rsync`
  1. System
  2. Settings
  3. Add-ons
  4. Install from repository
  5. LibreELEC Add-ons
  6. Program add-ons
  7. Network Tools
  8. Install
