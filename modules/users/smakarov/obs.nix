{ config, pkgs, ... }:
{
  home-manager.users.smakarov.programs = {
    obs-studio = {
      enable = config.deviceSpecific.isHomeMachine;
      plugins = with pkgs; [ obs-v4l2sink ];
    };
  };
}
