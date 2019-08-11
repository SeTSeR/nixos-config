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
    steam
    texlive.combined.scheme-full
    torsocks
    vk-messenger
    wpa_supplicant_gui
    xpdf
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
    imagemagick7
    nitrogen
    tdesktop
    thunderbird
    unrar
    unzip
    wakatime
    xclip
    fd
    ripgrep
    spotify
    pr64977.telega-server
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
