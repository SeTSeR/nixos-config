{ config, pkgs, lib, ... }:
let
  homePackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.ru
    djview
    gnuplot
    graphviz
    nixfmt
    spotify
    steam
    texlive.combined.scheme-full
    torsocks
    vk-messenger
    wpa_supplicant_gui
    xpdf
  ];
  cppPackages = with pkgs; [
    cacos
    ccls
    clang_8
    irony-server
  ];
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
    efibootmgr
    gnupg
    htop
    imagemagick7
    nitrogen
    tdesktop
    thunderbird
    unrar
    unzip
    wakatime
    xclip
  ];
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
