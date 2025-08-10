#!/bin/bash

# Intro
echo "
[ Info ] ● Loading Script
[ Info ] ● Checking Linux Distrobution
[ Info ] ● Loading Commands

              ● ● ● ●
          _______________
     
    🖥️ Welcome to Gnome-Scripts !

"

# Detect Distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "
              ● ● ● ● 
         __________________

       ❌ aborting script ...
"
    exit 1
fi

# Check supported distros
if [[ "$DISTRO" != "ubuntu" && "$DISTRO" != "debian" && "$DISTRO" != "arch" && "$DISTRO" != "manjaro" ]]; then
    echo "
              ● ● ● ● 
         __________________

       ❌ aborting script ...
"
    exit 1
fi

# Ask to proceed
read -rp "Proceed with script ? (y/N) " proceed
if [[ ! "$proceed" =~ ^[Yy]$ ]]; then
    echo "
              ● ● ● ● 
         __________________

       ❌ aborting script ...
"
    exit 0
fi

# Install packages
echo "[ Info ] Installing required packages..."
if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
    sudo apt update
    sudo apt install -y git curl wget fastfetch gnome-tweaks
elif [[ "$DISTRO" == "arch" || "$DISTRO" == "manjaro" ]]; then
    sudo pacman -Sy --noconfirm git curl wget fastfetch gnome-tweaks
fi

# Prepare directories
cd ~ || exit
mkdir -p .themes
mkdir -p .icons

# Download & Install WhiteSur Themes
cd ~/Downloads || exit

# WhiteSur GTK Theme
if [[ ! -d "WhiteSur-gtk-theme" ]]; then
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
fi
cd WhiteSur-gtk-theme || exit
./install.sh -t all
cd ..

# WhiteSur Icon Theme
if [[ ! -d "WhiteSur-icon-theme" ]]; then
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
fi
cd WhiteSur-icon-theme || exit
./install.sh
cd ..

# WhiteSur Cursor Theme
if [[ ! -d "WhiteSur-cursors" ]]; then
    git clone https://github.com/vinceliuice/WhiteSur-cursors.git
fi
cd WhiteSur-cursors || exit
./install.sh
cd ..

# Finish
echo "


              ● ● ● ●
         __________________

        ✅ Script Finished !

"

# Ask for reboot
read -rp "Do you want to reboot now ? (y/N) " reboot_now
if [[ "$reboot_now" =~ ^[Yy]$ ]]; then
    sudo reboot
else
    clear
    exit 0
fi
