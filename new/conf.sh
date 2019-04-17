#!/bin/bash
#####     Created by: ag
#####     --------------------------------------------------
#####     1. Configuration
    home_dir=/home/$1
	##### a) xorg
		sudo pacman --noconfirm --needed -Syu
		sudo pacman --noconfirm --needed -S xorg-server xorg-xinit xorg-xsetroot bash-completion gcc make pkg-config libx11 libxft libxinerama ttf-ubuntu-font-family
		sudo pacman --noconfirm --needed -S filezilla gimp inkscape firefox neovim rxvt-unicode zip unrar unzip ranger htop
		sudo pacman --noconfirm --needed -S scrot w3m lynx atool highlight xclip mupdf mplayer transmission-cli openssh
		sudo pacman --noconfirm --needed -S ncmpcpp pulseaudio	wget zathura conky 
		sudo pacman --noconfirm --needed -S nitrogen compton youtube-dl sxiv entr
		sudo pacman --noconfirm --needed -S gimp kodi qrencode netcat
		sudo pacman --noconfirm --needed -S termbin noto-fonts neomutt urlview
		#lspci | grep -e VGA -e 3D
    ##### b) git
    	cd home_dir
		sudo pacman --noconfirm --needed -S git
		git clone https://git.suckless.org/dwm
		git clone https://git.suckless.org/dmenu
		git clone https://git.suckless.org/st
		git clone https://git.suckless.org/surf
		echo -e "
		while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
		do
			sleep 1
		done &
		exec dwm
		" > ~/.xinitrc
		cd $home_dir/dwm/   && make clean install
		cd $home_dir/dmenu/ && make clean install
		cd $home_dir/st/   && make clean install
		cd $home_dir/surf/ && make clean install
	##### c) startx
		startx
