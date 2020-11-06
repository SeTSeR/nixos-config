# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, name, ... }:
rec {
  imports = [ # Include the results of the hardware scan.
    (./machines + "/${name}.nix")
    inputs.home-manager.nixosModules.home-manager
    (import ./modules device)
  ];

  device = name;

  # Select internationalisation properties.
  console = {
    font = "cyr-sun16";
    keyMap = "ruwin_cplk-UTF-8";
  };
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}
