{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
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
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "colorize"
        "command-not-found"
        "git"
        "git-extras"
        "github"
      ];
    };
    shellAliases = {
      vim = "vim-custom";
    };
  };
}
