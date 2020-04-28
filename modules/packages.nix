{ config, pkgs, lib, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nix.overlay
    (import ./overlay.nix { inherit inputs; })
    (import inputs.emacs-overlay)
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.etc.nixpkgs.source = inputs.nixpkgs;
  nix = {
    package = pkgs.nixFlakes;
    nixPath = lib.mkForce [
      "nixpkgs=/etc/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
    ];

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    optimise.automatic = true;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "smakarov" "root" "@wheel" ];
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
