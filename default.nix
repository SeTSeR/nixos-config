# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

device:
{ config, pkgs, options, ... }:

let unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./imports/home-manager/nixos
      ./modules
    ];
  inherit device;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
 
  nixpkgs.config = {
    # For Steam
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import imports/nixpkgs-unstable {
        config = config.nixpkgs.config;
      };
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

  # Enable automatic upgrades
  system.autoUpgrade.enable = true;
}
