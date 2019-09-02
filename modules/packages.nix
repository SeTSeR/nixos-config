{ config, pkgs, lib, ... }:
let nixpkgs-tars = "https://github.com/NixOS/nixpkgs/archive/";
in {
  nixpkgs.overlays = [ (import ./overlay.nix) ];

  nixpkgs.pkgs = import ../imports/nixpkgs {
    config = {
      allowUnfree = true;

      packageOverrides = pkgs: {
        stable = import (pkgs.fetchzip {
          url = "${nixpkgs-tars}19.03.zip";
          sha256 = "0q2m2qhyga9yq29yz90ywgjbn9hdahs7i8wwlq7b55rdbyiwa5dy";
        }) {
          config = config.nixpkgs.config;
        };
      };
    } // config.nixpkgs.config;
  };

  nix = {
    nixPath = lib.mkForce [
      "nixpkgs=${../imports/nixpkgs}"
      "home-manager=${../imports/home-manager}"
      "nixos-config=/etc/nixos/configuration.nix"
    ];

    package = pkgs.stable.nixStable;
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
    postgresql
  ];
}
