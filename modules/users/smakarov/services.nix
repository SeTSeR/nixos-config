{ config, pkgs, ... }:
{
  home-manager.users.smakarov = {
    services.redshift = {
      enable = true;
      brightness.day = "1";
      brightness.night = "0.5";
      provider = "geoclue2";
      temperature.night = 1588;
    };
    services.blueman-applet.enable = true;
  };
}
