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
  ];
  commonPackages = with pkgs;
  [
    libwebp
    fd
    flameshot
    stable.ffmpeg-full
    git-crypt
    htop
    nodejs-12_x
    ripgrep
    spotify
    tridactyl-native
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
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
