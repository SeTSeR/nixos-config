{ config, pkgs, lib, ... }:
let
  homePackages = with pkgs; [ xpdf djview torsocks ];
  cppPackages = with pkgs; [ irony-server clang cmake ];
  rustPackages = with pkgs; [
    cargo
    rustc
    rustPlatform.rustcSrc
    rustracer
    jetbrains.clion
  ];
  commonPackages = with pkgs;
  [
    tdesktop
    rxvt_unicode
    imagemagick7
    xclip
    unzip
    nitrogen
    firefox
    efibootmgr
    gnupg
    htop
    unrar
    thunderbird
    wakatime
    vscode
  ] ++ cppPackages ++ rustPackages;
in {
  home-manager.users.rassel1976 = {
    nixpkgs.config = {
      # For Steam
      allowUnfree = true;
    };

    home.packages = commonPackages
    ++ lib.optionals config.deviceSpecific.isHomeMachine homePackages;
  };
}
