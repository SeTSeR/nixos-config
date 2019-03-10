{ config, pkgs, ... }:
{
  home-manager.users.smakarov = {
    services.redshift = {
      enable = true;
      brightness.day = "1";
      brightness.night = "0.7";
      provider = "geoclue2";
      temperature.night = 1588;
    };
    services.blueman-applet.enable = true;
    services.udiskie = {
      enable = true;
      automount = false;
      notify = true;
      tray = "auto";
    };
  };
}
