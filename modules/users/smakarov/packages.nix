{ config, pkgs, lib, ... }:
let unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
    homePackages = with pkgs; [
      unstable.discord
      unstable.spotify
      unstable.steam
      unstable.vk-messenger
      xpdf
      djview
      torsocks
    ];
    cppPackages = with pkgs; [
      irony-server
      clang
    ];
    rustPackages = with pkgs; [
      cargo
      rustc
      rustPlatform.rustcSrc
      rustracer
      jetbrains.idea-ultimate
    ];
    commonPackages = with pkgs; [
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
      thunderbird
      wakatime
    ] ++ cppPackages ++ rustPackages;
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

    home.packages = commonPackages ++ lib.optionals config.deviceSpecific.isHomeMachine homePackages;
  };
}
