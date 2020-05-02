{ config, pkgs, lib, ... }:
let
  homePackages = with pkgs; [
    djview
    dot2tex
    gnuplot
    graphviz
    nixfmt
    python37Packages.pygments
    steam
    (steam.override { extraPkgs = pkgs: [ openmw ]; }).run
    texlive.combined.scheme-full
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
    git-crypt
    htop
    imagemagick7
    nitrogen
    pinentry-qt
    ripgrep
    spotify
    thunderbird
    tridactyl-native
    unrar
    unzip
    wakatime
    xclip
    zoom-us
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
