{ config, pkgs, lib, ... }:
let
  homePackages = with pkgs; [
    djview
    dot2tex
    gnuplot
    graphviz
    python37Packages.pygments
    steam
    (steam.override { extraPkgs = pkgs: [ openmw ]; }).run
    texlive.combined.scheme-full
    docker-compose
  ];
  commonPackages = with pkgs;
  [
    emacsPackages.melpaPackages.telega
    libwebp
    fd
    ffmpeg-full
    git-crypt
    htop
    imagemagick7
    ripgrep
    spotify
    thunderbird
    tridactyl-native
    xclip
    wakatime
  ];
in {
  home-manager.users.smakarov = {
    xdg.configFile."nixpkgs/config.nix".text = ''
      {
        allowUnfree = true;
      }
    '';

    home.packages = commonPackages ++ lib.optionals config.deviceSpecific.isHomeMachine homePackages;

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
