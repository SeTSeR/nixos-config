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
    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "ruwin_cplk-UTF-8";
  };
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
}
