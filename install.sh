#!/bin/sh

echo "SeTSeR's config installation."

nix-shell -p "git" --run "git submodule update --init --recursive"

CONFIG="/mnt/etc/nixos/configuration.nix"
USER_HOME="/home/smakarov"

echo "Creating ${CONFIG}"
mkdir -p /mnt/etc/nixos
echo "{config, pkgs, ...}:
{
    imports = [
        ./hardware-configuration.nix
        $(pwd)
    ];
}" > $(CONFIG)
echo "Done"
echo "Installing"
nixos-generate-config --root /mnt
nixos-install
ln -s $(pwd)/.config/i3status /mnt/$USER_HOME/.config/i3status
ln -s $(pwd)/.config/nixpkgs /mnt/$USER_HOME/.config/nixpkgs
echo "Done"
