{ config, pkgs, lib, ... }:
let imports = import ../nix/sources.nix;
in {
  nixpkgs.overlays = [ (import ./overlay.nix) ];

  nixpkgs.pkgs = import imports.nixpkgs {
    config = {
      allowUnfree = true;
    } // config.nixpkgs.config;
  };

  environment.etc.nixpkgs.source = imports.nixpkgs;
  nix = {
    nixPath = lib.mkForce [
      "nixpkgs=/etc/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
    ];

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    extraOptions = "keep-outputs = true";
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
    mate.mate-polkit
  ];
}
