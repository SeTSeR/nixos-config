{ config, pkgs, ... }:
{
  nixpkgs.config = {
    # For Steam
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import ../imports/nixpkgs-unstable {
        config = config.nixpkgs.config;
      };
    };
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
