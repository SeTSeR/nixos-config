{ config, pkgs, lib, ... }:
{
  home-manager.users.smakarov = {
    xdg.configFile."nixpkgs/config.nix".text = ''
      {
        allowUnfree = true;
      }
    '';

    home.packages = with pkgs; [
      envsubst
      vscode
      djview
      dot2tex
      gnuplot
      graphviz
      python37Packages.pygments
      steam
      (steam.override { extraPkgs = pkgs: [ openmw ]; }).run
      texlive.combined.scheme-full
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

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
