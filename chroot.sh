#####  CHROOT STARTS               #####
#####  TIME ZONE                   #####
sudo pacman -S ntp
sudo timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
hwclock-systohc
#####  NETWORK MANAGER             #####
pacman --noconfirm --needed -S networkmanager
systemctl enable NetworkManager
systemctl start NetworkManager
#####  BOOT LOADER GRUB            #####
pacman --noconfirm --needed -S grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
#####  LOCALIZATION                #####
echo "en_US.UTF-8 UTF-8" >> /etc/local.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
#####  ROOT PASSWORD               #####
passwd
read -p "Press any key..."
#####  HOSTNAME
echo $COMPUTER_NAME >> /etc/hostname
echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1        localhost" >> /etc/hosts
echo "127.0.0.1  " + $COMPUTER_NAME+ ".localdomain "+ $COMPUTER_NAME >> /etc/hosts
#####  CHROOT EXITS                #####
exit