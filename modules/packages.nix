{ config, pkgs, lib, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
    (import ./overlay.nix { inherit inputs; inherit config; })
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.etc.nixpkgs.source = inputs.nixpkgs;
  nix = {
    package = pkgs.nixUnstable;
    nixPath = lib.mkForce [
      "nixpkgs=/etc/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
    ];

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    optimise.automatic = true;

    registry.nixpkgs.flake = inputs.nixpkgs;

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    trustedUsers = [ "smakarov" "root" "@wheel" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    networkmanager
    btrfs-progs
    pulseaudio
    sudo
    manpages
    fuse_exfat
  ];
}
