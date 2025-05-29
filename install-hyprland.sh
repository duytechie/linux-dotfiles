#!/bin/bash

# Colors
INFO="[\e[1;36mINFO\e[0m]"
DONE="[\e[1;32mDONE\e[0m]"

LOGFILE="hyprland-install.log"
exec > >(tee -a "$LOGFILE") 2>&1

sleep 3

### PART 1: Base System Setup ###
echo -e "$INFO Initializing pacman keyring..."
sudo pacman-key --init
sudo pacman-key --populate archlinux

echo -e "$INFO Updating system and installing base-devel + git..."
sudo pacman -Syu --noconfirm --needed base-devel git

BASE_PACKAGES=(
  neovim tldr fzf wget curl tar unzip gzip gtop fastfetch \
  fd ripgrep bat eza tree-sitter tree-sitter-cli \
  zsh git git-delta man thunar pam-u2f libfido2 keychain copyq \
  zathura zathura-pdf-mupdf gammastep
)



echo -e "$INFO Installing base packages..."
for pkg in "${BASE_PACKAGES[@]}"; do
  echo -e "$INFO Installing: $pkg"
  sudo pacman -S --noconfirm --needed "$pkg" || echo "$INFO Failed to install: $pkg"
done

sleep 3

### PART 2: GUI Apps + Hyprland Setup ###

GUI_PACKAGES=(
  noto-fonts ttf-opensans ttf-firacode-nerd noto-fonts-cjk \
  bluez bluez-utils pulseaudio-bluetooth \
  flameshot mpv \
  hyprland kitty wofi xdg-desktop-portal-hyprland waybar \
  qt5-wayland qt6-wayland hyprpaper hyprsunset gdm
)

echo -e "$INFO Installing GUI + Hyprland packages..."
for pkg in "${GUI_PACKAGES[@]}"; do
  echo -e "$INFO Installing: $pkg"
  sudo pacman -S --noconfirm --needed "$pkg" || echo "$INFO Failed to install: $pkg"
done

sleep 3

# Install Yay
if ! command -v yay &>/dev/null; then
  echo -e "$INFO Yay not found. Installing Yay..."
  cd /tmp || exit 1
  git clone https://aur.archlinux.org/yay.git
  cd yay || exit 1
  makepkg -si --noconfirm
else
  echo -e "$INFO Yay is already installed."
fi

echo -e "$INFO Verifying Yay..."
yay --version

sleep 3

echo -e "$INFO Installing AUR packages using Yay..."

AUR_PACKAGES=(
  obsidian firefox btop tmux starship ghostty font-viewer font-manager \
  ykman yubico-authenticator-bin npm go yazi brightnessctl \
  thunar-archive-plugin swaylock-effects wlogout pavucontrol \
  noto-fonts-emoji mako network-manager-applet blueman nm-applet \
  hyprland-polkit-agent microsoft-edge-stable-bin \
  ttf-meslo-nerd ttf-nerd-fonts-symbols ttf-jetbrains-mono-nerd ttf-ms-fonts
)

for pkg in "${AUR_PACKAGES[@]}"; do
  echo -e "$INFO Installing AUR package: $pkg"
  yay -S --noconfirm --needed "$pkg" || echo "$INFO Failed to install: $pkg"
done

echo -e "$DONE All packages installed successfully!"
echo -e "$INFO Manual configuration and dotfiles can be applied next."

sleep 3

echo -e "$INFO Enabling Bluetooth service..."
sudo systemctl enable --now bluetooth.service

echo -e "$INFO Enabling GDM display manager..."
sudo systemctl enable gdm

echo -e "$DONE GDM enabled as default login manager and Bluetooth service active!"
