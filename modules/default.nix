device:
{ ... }: {
  imports = [
    ./containers.nix
    ./config.nix
    ./devices.nix
    ./fonts.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    ./secrets.nix
    ./services.nix
    ./users
  ];
}
