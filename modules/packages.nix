{ config, pkgs, lib, ... }: {
nixpkgs.overlays = [ (import ./overlay.nix) ];

  nixpkgs.pkgs = import ../imports/nixpkgs { config.allowUnfree = true; }
  // config.nixpkgs.config;

  nix = {
    nixPath = lib.mkForce [
      "nixpkgs=${../imports/nixpkgs}"
      "home-manager=${../imports/home-manager}"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    networkmanager
    btrfs-progs
    gcc
    gdb
    pulseaudio
    sudo
    lightdm
    manpages
    fuse_exfat
  ];
}
