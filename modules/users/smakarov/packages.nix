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
    gnuplot
    python37Packages.pygments
    niv
  ];
  commonPackages = with pkgs;
  [
    aspell
    aspellDicts.en
    aspellDicts.ru
    tdesktop
    imagemagick7
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
    emacsPackagesNg.melpaPackages.telega
    kitty
    pinentry-qt
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
