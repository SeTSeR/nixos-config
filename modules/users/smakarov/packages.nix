{ config, pkgs, lib, ... }:
let
  homePackages = with pkgs; [
    djview
    gnuplot
    graphviz
    niv
    nixfmt
    python37Packages.pygments
    steam
    texlive.combined.scheme-full
    vk-messenger
    wpa_supplicant_gui
  ];
  commonPackages = with pkgs;
  [
    aspell
    aspellDicts.en
    aspellDicts.ru
    bitwarden-cli
    efibootmgr
    fd
    ffmpeg-full
    htop
    imagemagick7
    lorri
    nitrogen
    pinentry-qt
    plantuml
    ripgrep
    spotify
    thunderbird
    tridactyl-native
    unrar
    unzip
    wakatime
    xclip
  ];
in {
  home-manager.users.smakarov = {
    home.file.".config/nixpkgs/config.nix".text = ''
      {
        allowUnfree = true;
      }
    '';

    home.packages = commonPackages ++ lib.optionals config.deviceSpecific.isHomeMachine homePackages;

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
