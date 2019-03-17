#!/bin/bash
set -e
##### ----- INSTALL AUR HELPERS ----- #####
sudo pacman -S git
cd
#####  install yay  #####
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd
#####  install trizen  #####
git clone https://aur.archlinux.org/trizen.git
$ cd trizen
$ sudo makepkg -si
cd
