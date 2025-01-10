#!/usr/bin/bash
# Copyright (c) 2024-2025 iiPython

# Preinstall requirements:
#   - networkmanager for network configuration
#   - linux-zen for the kernel

# Software used:
#   - Window Manager: labwc
#   - Terminal: foot
#   - Launcher: rofi (wayland fork)
#   - Audio Server: pipewire
#   - Browser: mercury

# Ensure Network Manager is running before doing anything else
sudo systemctl enable --now NetworkManager
sleep 5

# Install our desktop
sudo pacman -S --noconfirm ly labwc swaybg waybar kanshi
sudo systemctl enable ly

# Setup our dotfiles
sudo pacman -S --noconfirm git stow
git clone https://github.com/iiPythonx/iiPythonx .dotfiles
cd .dotfiles
./stow.sh
cd

# Setup fish shell
sudo pacman -S --noconfirm fish
sudo chsh -s /usr/bin/fish $(whoami)

# Setup AUR
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U --noconfirm "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst"
sudo pacman -U --noconfirm "https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst"
sudo pacman -Syy --noconfirm yay-git

# Install basic desktop applications
sudo pacman -S --noconfirm thunderbird foot nemo python micro starship eza uv keychain rofi-wayland nicotine+ mpv easyeffects
sudo ln -s /usr/bin/micro /usr/bin/nano
yay -S iipython-feishin-bin jellyfin-media-player
