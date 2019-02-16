{ config, pkgs, ... }:
{
  home-manager.users.smakarov.programs.urxvt = {
    enable = true;
    scroll = {
      bar.enable = false;
      scrollOnOutput = false;
      scrollOnKeystroke = true;
    };
    fonts = [ "xft:Source Code Pro:pixelsize=16:antialias=true:hinting=true" ];
  };
}
