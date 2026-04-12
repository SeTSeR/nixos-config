{ config, pkgs, ... }:
let sources = import ./npins;
in {
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.flake.source = sources.nixpkgs;
  nix.nixPath = [
    "nixpkgs=flake:nixpkgs"
  ];
}
