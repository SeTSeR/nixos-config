{ pkgs, config, ... }:
{
  home-manager.users.smakarov.programs.zsh = {
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