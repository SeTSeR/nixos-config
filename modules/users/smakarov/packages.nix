{ config, pkgs, lib, ... }:
let
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
    unrar
    thunderbird
    wakatime
    fd
    ripgrep
    spotify
  ];
in {
  home-manager.users.smakarov = {
    home.file.".config/nixpkgs/config.nix".text = ''
      {
        allowUnfree = true;
      }
    '';

    home.packages = commonPackages;
  };
}
