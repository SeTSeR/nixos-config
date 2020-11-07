device:
{ lib, ... }:
{
  imports = [
    ./config.nix
    ./devices.nix
    ./fonts.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    ./secrets.nix
    ./services.nix
    ./users
  ] ++ lib.optionals (device == "ASUS-Laptop") [ ./erase.nix ];
}
