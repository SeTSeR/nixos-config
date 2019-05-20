{ config, pkgs, lib, ... }:
{
  nixpkgs.overlays = [ (self: old:
    let cacosPkg = { gcc8Stdenv, fetchgit, pkgconfig, boost, cmake, curl, gcc8, git }:
      let
        boostpkg = boost.override {
          enableStatic = true;
        };
        stdenv = gcc8Stdenv;
      in stdenv.mkDerivation rec {
        name = "cacos";

        src = fetchgit {
          url = "https://github.com/BigRedEye/cacos";
          rev = "v0.1.4";
          sha256 = "1b6bph086qlaz5l0zslakniyzx4cwg1532vmza2fci4x64l54mkw";
          fetchSubmodules = true;
        };

        nativeBuildInputs = [ cmake pkgconfig ];
        buildInputs = [ boostpkg curl gcc8 git ];

        cmakeFlags = [ "-DCMAKE_USE_CONAN=OFF -DCMAKE_BUILD_TYPE=Release" ];

        enableParallelBuilding = true;

        meta = {
          homepage = "https://github.com/BigRedEye/cacos";
          description = "Ejudge client and local testing system";
          license = stdenv.lib.licenses.mit;
        };
      };
    in {
      cacos = self.pkgs.callPackage cacosPkg {};
    }
  )];

  nixpkgs.pkgs = import ../imports/nixpkgs
  {
    config.allowUnfree = true;
  } // config.nixpkgs.config;

  nix = {
    nixPath = lib.mkForce
    [
      "nixpkgs=${../imports/nixpkgs}"
      "home-manager=${../imports/home-manager}"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
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
