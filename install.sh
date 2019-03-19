#!/bin/bash
set -e
##### ----- INSTALL AUR HELPERS ----- #####
sudo pacman  --noconfirm --needed -S git
cd
#####  install yay  #####
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm --needed -si
cd
#####  install trizen  #####
git clone https://aur.archlinux.org/trizen.git
cd trizen
sudo makepkg --noconfirm --needed -si
cd
