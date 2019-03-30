#!/bin/bash
set -e
one_two(){
NEXT=0; until [ $NEXT -eq 1 ]; do
  read -p "$1" ANSWER
  case "$ANSWER" in 
    [oO][nN][eE]|[1]) 
      
#####  CHECKING CONNECTION                     #####  
ping -q -w1 -c1 google.com &>/dev/null && echo "You are connected to the internet!" || (echo -e "\033[0;36m'You are not connected to the internet!'\033[0;0m";wifi-menu;exit;)
#####  INPUTS                                  #####
read -p "Enter your hostname: " COMPUTER_NAME
cat<<EOF | fdisk /dev/sda
n
p
1


w
EOF
yes | mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt
lsblk
read -p "Press any key..."
sed -i '1s/^/echo "Server = http://mirror.lnx.sk/pub/linux/archlinux/$repo/os/$arch"\n/' /etc/pacman.d/mirrorlist
pacstrap /mnt base
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
#####  LOCALIZATION                #####
echo "en_US.UTF-8 UTF-8" >> /etc/local.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
#####  HOSTNAME
echo $COMPUTER_NAME >> /etc/hostname
echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1        localhost" >> /etc/hosts
echo "127.0.0.1  " + $COMPUTER_NAME+ ".localdomain "+ $COMPUTER_NAME >> /etc/hosts
#####  BOOT LOADER GRUB            #####
pacman --noconfirm --needed -S grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
#####  EXIT ARCH-CHROOT            #####
exit
echo "####################     INSTALLATION 1 FINISHED   ####################"
poweroff

      NEXT=1
      ;;
    [tT][wO][oO]|[2]) 
      
#####  ACCOUNT ETC/SUDOERS PERMISSION          #####
accountperms(){
  sed -i "/#MY_PERMISSION/d" /etc/sudoers
  echo -e "$@ #MY_PERMISSION" >> /etc/sudoers ;}
read -p "Enter your username: " USER_NAME
dhcpcd enp0s3
pacman -S --noconfirm --needed sudo
accountperms "%wheel ALL=(ALL) NOPASSWD: ALL"
useradd -m -s /bin/bash $USER_NAME
passwd $USER_NAME
exit
## login
sudo pacman --noconfirm --needed -S git
git clone https://github.com/ilyas-sadykov/dotfiles
cd dotfiles/
sudo bash install.sh $USER_NAME
echo "####################     INSTALLATION 2 FINISHED   ####################"
startx
pkill X
startx

      NEXT=1
      ;;
  esac
done;}
one_two "Which installation do you want (1/2)? "