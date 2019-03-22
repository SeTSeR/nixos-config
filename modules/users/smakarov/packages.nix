{ config, pkgs, lib, ... }:
let homePackages = with pkgs; [
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
      jetbrains.clion
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
        unstable = import ../../../imports/nixpkgs-unstable {
          config = config.nixpkgs.config;
        };
      };
    };

    home.packages = commonPackages ++ lib.optionals config.deviceSpecific.isHomeMachine homePackages;
  };
}
