#!/bin/sh

echo "SeTSeR's config installation."

nix-env -iA nixos.git
git submodule update --init --recursive

CONFIG="/mnt/etc/nixos/configuration.nix"
USER_HOME="/home/smakarov"

echo "Creating ${CONFIG}"
mkdir -p /mnt/etc/nixos
read -p "Enter your device name:" HOSTNAME
echo "import $(pwd) $HOSTNAME" > $CONFIG
echo "Done"
echo "Installing"
nixos-generate-config --root /mnt
ln -s /mnt/etc/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
nixos-install
mkdir /mnt/$USER_HOME/.config
ln -s $(pwd)/.config/i3status /mnt/$USER_HOME/.config/i3status
ln -s $(pwd)/.config/nixpkgs /mnt/$USER_HOME/.config/nixpkgs
echo "Done"
