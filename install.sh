#!/bin/sh

echo "SeTSeR's config installation."

nix-env -iA nixos.git

CONFIG="/mnt/etc/nixos/configuration.nix"
USER_HOME="/home/smakarov"

echo "Creating ${CONFIG}"
mkdir -p /mnt/etc/nixos
read -p "Enter your device name:" HOSTNAME
echo "import $(pwd) \"$HOSTNAME\"" > $CONFIG
echo "Done"
echo "Installing"
nixos-generate-config --root /mnt
ln -s /mnt/etc/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
nixos-install
rm /etc/nixos/hardware-configuration.nix
nix-env -e nixos.git
if [ $? -eq 0 ]; then
    echo "Done"
else
    rm -r /mnt/etc/nixos
    echo "Installation failed"
fi
