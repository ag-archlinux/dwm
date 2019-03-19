#!/bin/bash
#####  FUNCTIONS SCRIPT                        #####
set -e
#####  QUESTION YES/NO FUNCTION                #####        
question_yesno(){
NEXT=0; until [ $NEXT -eq 1 ]; do
  read -p "$1" ANSWER
  case "$ANSWER" in 
    [yY][eE][sS]|[yY]) 
      $2
      NEXT=1
      ;;
    [nN][oO]|[nN]) 
      $3
      NEXT=1
      ;;
  esac
done;}
#####  ACCOUNT ETC/SUDOERS PERMISSION          #####
accountperms(){
  sed -i "/#MY_PERMISSION/d" /etc/sudoers
  echo -e "$@ #MY_PERMISSION" >> /etc/sudoers ;}
aur(){
  cp -vf /etc/pacman.conf /etc/pacman_backup.conf
  echo -e "$1" >> /etc/pacman.conf 
  echo -e "$2" >> /etc/pacman.conf 
  echo -e "$3" >> /etc/pacman.conf
  sudo pacman --noconfirm --needed -Sy yaourt
  cp -vf /etc/pacman_backup.conf /etc/pacman.conf
  rm /etc/pacman_backup.conf;}

package_aur(){
    package="$1"

#####  INSTALLATION OF AUR PACKAGES  #####
#----------------------------------------------------------------------------------
    if pacman -Qi $package &> /dev/null; then
    echo "####################  "$package" IS ALREADY INSTALLED  ####################"
    else
      if pacman -Qi yay &> /dev/null; then
        echo "####################        Installing with yay        ####################"
        yay -S --noconfirm $package
      elif pacman -Qi trizen &> /dev/null; then
        echo "####################      Installing with trizen       ####################"
        trizen -S --noconfirm --needed --noedit $package
      elif pacman -Qi yaourt &> /dev/null; then
        echo "####################      Installing with yaourt       ####################"
        yaourt -S --noconfirm $package
      elif pacman -Qi pacaur &> /dev/null; then
        echo "####################      Installing with pacaur       ####################"
        pacaur -S --noconfirm --noedit  $package
      elif pacman -Qi packer &> /dev/null; then
        echo "####################      Installing with packer       ####################"
        packer -S --noconfirm --noedit  $package
      fi
      if pacman -Qi $package &> /dev/null; then
        echo "####################   "$package" HAS BEEN INSTALLED   ####################"
      else
        RED='\033[0;31m'
            NC='\033[0m'
        echo -e "#################### ${RED}"$package"${NC} HAS NOT BEEN INSTALLED ####################"
      fi
    fi
}