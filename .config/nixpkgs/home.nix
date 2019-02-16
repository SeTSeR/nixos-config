{ config, pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./modules
  ];

  home.sessionVariables.EDITOR = "vim-custom";

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
    file
    stdman
    vk-messenger
  ];

  xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "solarized";
      repo = "xresources";
      rev = "025ceddbddf55f2eb4ab40b05889148aab9699fc";
      sha256 = "0lxv37gmh38y9d3l8nbnsm1mskcv10g3i83j0kac0a2qmypv1k9f";
    } + "/Xresources.light"
  );
}
