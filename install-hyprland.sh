#!/bin/bash

# Colors
INFO="[\e[1;36mINFO\e[0m]"
DONE="[\e[1;32mDONE\e[0m]"

LOGFILE="hyprland-install.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo -e "$INFO Initializing pacman keyring..."
sudo pacman-key --init
sudo pacman-key --populate archlinux

echo -e "$INFO Updating system and installing core packages..."

sudo pacman -Syu --noconfirm --needed base-devel git

echo -e "$INFO Installing core CLI + GUI apps..."

sudo pacman -S --noconfirm \
  neovim tldr fzf wget curl tar unzip gzip gtop fastfetch \
  fd ripgrep bat eza tree-sitter tree-sitter-cli \
  zathura zathura-pdf-mupdf gammastep \
  noto-fonts ttf-opensans ttf-firacode-nerd noto-fonts-cjk \
  zsh git git-delta \
  bluez bluez-utils pulseaudio-bluetooth man \
  pam-u2f libfido2 keychain copyq telegram-desktop \
  obs-studio flameshot mpv bitwarden thunar

echo -e "$INFO Installing Hyprland and Wayland packages..."

sudo pacman -S --noconfirm \
  hyprland kitty wofi xdg-desktop-portal-hyprland waybar \
  qt5-wayland qt6-wayland hyprpaper hyprsunset

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

echo -e "$INFO Installing AUR and extra apps using Yay..."

yay -S --noconfirm \
  obsidian firefox 1password-cli btop tmux starship \
  ykman yubico-authenticator-bin npm go yazi brightnessctl thunar-archive-plugin swaylock-effects wlogout pavucontrol noto-fonts-emoji mako network-manager-applet blueman nm-applet hyprpolkitagent microsoft-edge-stable-bin \
  ttf-meslo-nerd-font-powerlevel10k ttf-nerd-fonts-symbols ttf-jetbrains-mono-nerd ghostty

echo -e "$DONE All packages installed successfully!"
echo -e "$INFO Manual configuration and dotfiles can be applied next."

echo -e "$INFO Enabling Bluetooth service..."
sudo systemctl enable --now bluetooth.service

echo -e "$INFO Installing and enabling SDDM display manager..."
sudo pacman -S --noconfirm sddm
sudo systemctl enable --now sddm

echo -e "$DONE SDDM enabled as default login manager and Bluetooth service active!"
