{ config, pkgs, lib, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
    inputs.nur.overlay
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
    ];
    binaryCaches = [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    requireSignedBinaryCaches = true;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    optimise.automatic = true;

    registry.nixpkgs.flake = inputs.nixpkgs;

    extraOptions = ''
      experimental-features = nix-command flakes
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
