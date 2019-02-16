{ config, pkgs, lib, ... }:
{
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
    python3
    stack
    htop
    unrar
    torsocks
    xpdf
    djview
    acpilight
    nix-zsh-completions
    python3
    vim-custom
    file
    stdman
    vk-messenger
  ];
}
