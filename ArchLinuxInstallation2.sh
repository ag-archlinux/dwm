#!/bin/bash
set -e
#####  UPDATE PACKAGES              #####
pacman --noconfirm --needed -Syyu
#####  GIT                          #####
pacman --noconfirm --needed -S git
#####  MY FUNCTIONS                 #####
git clone https://github.com/ag-archlinux/dwm
source /root/dwm/functions.sh
#####  BASH COMPLETION              #####	
pacman  --noconfirm --needed  -S bash-completion
#####  INPUTS                       #####
read -p "Enter your username: " PERSONAL_ACCOUNT
#####  PERSONAL ACCOUNT             #####
useradd -m -g users -G audio,video,network,wheel,storage -s /bin/bash $PERSONAL_ACCOUNT
#####  PASSWORD OF PERSONAL ACCOUNT #####
passwd $PERSONAL_ACCOUNT
#####  ACCOUNT SUDO PERMITIONS      #####
accountperms "%wheel ALL=(ALL) NOPASSWD: ALL"
#####  UPDATE PACKAGES              #####
sudo pacman --noconfirm --needed -Syu
#####  XORG                         #####
sudo pacman  --noconfirm --needed -S xorg-server xorg-apps xorg-xinit
lspci | grep -e VGA -e 3D
#####  LIGHTDM                      #####
sudo pacman --noconfirm --needed -S lightdm
sudo pacman --noconfirm --needed -S lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo systemctl enable lightdm.service
#####  PROGRAMS                     #####
sudo pacman --noconfirm --needed -S ncmpcpp pulseaudio	wget zathura conky 
sudo pacman --noconfirm --needed -S lynx surf nitrogen compton youtube-dl sxiv entr filezilla zip htop
sudo pacman --noconfirm --needed -S firefox transmission-cli gimp dmenu kodi rxvt-unicode qrencode netcat
#####  LOGIN TO USER                #####
su - $PERSONAL_ACCOUNT -c "
#####  AUR PACKAGES                 #####
git clone https://github.com/ag-archlinux/dwm
source /home/$PERSONAL_ACCOUNT/dwm/install.sh
#####  AUR INSTALL                  #####
package_aur st
package_aur polybar
package_aur noto-fonts-all
package_aur dwm
"
#####  START                        #####
startx
echo "####################     INSTALLATION FINISHED     ####################"