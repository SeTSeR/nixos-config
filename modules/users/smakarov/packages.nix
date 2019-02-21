{ config, pkgs, lib, ... }:
{
  nixpkgs.overlays = [
    (import ../../../imports/nixpkgs-overlays)
  ];

  home-manager.users.smakarov.programs.home-manager.enable = true;

  home-manager.users.smakarov.home.packages = with pkgs; [
    steam
    discord
    spotify
    tdesktop
    rxvt_unicode
    imagemagick7
    xclip
    unzip
    nitrogen
    firefox
    efibootmgr
    gnupg
    stack
    htop
    unrar
    torsocks
    xpdf
    djview
    nix-zsh-completions
    vim-generic
    file
    stdman
    vk-messenger
  ];
}
