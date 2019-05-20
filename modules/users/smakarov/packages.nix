{ config, pkgs, lib, ... }:
let homePackages = with pkgs; [
      discord
      spotify
      vk-messenger
      steam
      xpdf
      djview
      torsocks
      graphviz
      texlive.combined.scheme-full
      cacos
      wpa_supplicant_gui
    ];
    cppPackages = with pkgs; [
      irony-server
      unstable.clang_8
      ccls
    ];
    rustPackages = with pkgs; [
      cargo
      rustc
      rustPlatform.rustcSrc
      rustracer
      rustfmt
      rls
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
        unstable = import ../../../imports/nixpkgs {
          config = config.nixpkgs.config;
        };
      };
    };

    home.packages = commonPackages ++ lib.optionals config.deviceSpecific.isHomeMachine homePackages;
  };
}
