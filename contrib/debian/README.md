
Debian
====================
This directory contains files used to package crimsond/crimson-qt
for Debian-based Linux systems. If you compile crimsond/crimson-qt yourself, there are some useful files here.

## crimson: URI support ##


crimson-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install crimson-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your crimson-qt binary to `/usr/bin`
and the `../../share/pixmaps/crimson128.png` to `/usr/share/pixmaps`

crimson-qt.protocol (KDE)

