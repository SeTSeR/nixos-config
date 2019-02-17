#!/bin/sh

echo "SeTSeR's config installation."

CONFIG="/mnt/etc/nixos/configuration.nix"
USER_HOME="/home/smakarov"

nix-shell -p git --run "git submodule update --init --recursive"

read -p "Do you know the password? [Y/n]: " ASK_PASSWORD
if [ "$ASK_PASSWORD" != "n" ]; then
    nix-shell -p gnupg --run "gpg -d secret.nix.gpg" > secret.nix
    echo "secret.nix extracted!"
else
    echo "{
    id_rsa = \"\";
}" > secret.nix
    echo "secret.nix created!"
fi

echo "Creating ${CONFIG}..."
mkdir -p /mnt/etc/nixos
read -p "Enter your device name: " HOSTNAME
echo "import $(pwd) \"$HOSTNAME\"" > $CONFIG
echo "Done!"
echo "Installing..."
nixos-generate-config --root /mnt
ln -s /mnt/etc/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
nixos-install
rm /etc/nixos/hardware-configuration.nix
if [ $? -eq 0 ]; then
    echo "Done!"
else
    rm -r /mnt/etc/nixos
    echo "Installation failed!"
fi
