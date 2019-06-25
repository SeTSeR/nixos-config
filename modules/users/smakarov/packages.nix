{ config, pkgs, lib, ... }:
let
  homePackages = with pkgs; [
    discord
    spotify
    vk-messenger
    steam
    xpdf
    djview
    torsocks
    graphviz
    texlive.combined.scheme-full
    cacos
    wpa_supplicant_gui
    racket
    gnuplot
    nixfmt
    aspell
    aspellDicts.en
    aspellDicts.ru
  ];
  cppPackages = with pkgs; [ irony-server clang_8 ccls ];
  rustPackages = with pkgs; [
    cargo
    rustc
    rustPlatform.rustcSrc
    rustracer
    rustfmt
    rls
  ];
  commonPackages = with pkgs;
  [
    tdesktop
    imagemagick7
    xclip
    unzip
    nitrogen
    efibootmgr
    gnupg
    htop
    unrar
    thunderbird
    wakatime
  ] ++ cppPackages ++ rustPackages;
in {
  home-manager.users.smakarov = {
    nixpkgs.config = {
      # For Steam
      allowUnfree = true;
    };

    home.file.".config/nixpkgs/config.nix".text = ''
      {
        allowUnfree = true;
      }
    '';

    home.packages = commonPackages
    ++ lib.optionals config.deviceSpecific.isHomeMachine homePackages;
  };
}
