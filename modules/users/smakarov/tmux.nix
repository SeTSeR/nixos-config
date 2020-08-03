{ config, pkgs, lib, ... }:
{
  home-manager.users.smakarov = {
    programs.tmux = {
      enable = true;
    };
  };
}
