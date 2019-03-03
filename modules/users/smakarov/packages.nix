{ config, pkgs, lib, ... }:
let unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  home-manager.users.smakarov = {
    nixpkgs.config = {
      # For Steam
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import unstableTarball {
          config = config.nixpkgs.config;
        };
      };
    };
    
    home.packages = with pkgs; [
      unstable.steam
      unstable.discord
      unstable.spotify
      unstable.tdesktop
      rxvt_unicode
      imagemagick7
      xclip
      unzip
      nitrogen
      firefox
      efibootmgr
      gnupg
      htop
      unrar
      torsocks
      xpdf
      djview
      nix-zsh-completions
      unstable.vk-messenger
      thunderbird
      wakatime
      irony-server
      clang
      cargo
      rustracer
      irony-server
    ];
  };
}
