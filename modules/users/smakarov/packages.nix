{ config, pkgs, lib, ... }:
let
  homePackages = with pkgs; [
    djview
    gnuplot
    graphviz
    nixfmt
    steam
    texlive.combined.scheme-full
    vk-messenger
    wpa_supplicant_gui
    python37Packages.pygments
    niv
    dwarf-fortress
  ];
  commonPackages = with pkgs;
  [
    aspell
    aspellDicts.en
    aspellDicts.ru
    xclip
    unzip
    nitrogen
    efibootmgr
    htop
    imagemagick7
    nitrogen
    spotify
    thunderbird
    tridactyl-native
    unrar
    unzip
    wakatime
    xclip
    fd
    ripgrep
    ffmpeg-full
    pinentry-qt
    bitwarden-cli
    plantuml
  ];
in {
  home-manager.users.smakarov = {
    home.file.".config/nixpkgs/config.nix".text = ''
      {
        allowUnfree = true;
      }
    '';

    home.packages = commonPackages ++ lib.optionals config.deviceSpecific.isHomeMachine homePackages;
  };
}
