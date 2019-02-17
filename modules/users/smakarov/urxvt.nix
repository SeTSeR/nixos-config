{ config, pkgs, ... }:
{
  home-manager.users.smakarov.programs.urxvt = {
    enable = true;
    scroll = {
      bar.enable = false;
      scrollOnOutput = false;
      scrollOnKeystroke = true;
    };
    fonts = [ "xft:Source Code Pro Medium:pixelsize=16:antialias=true:hinting=true" "xft:Source Code Pro Medium for Powerline:pixelsize=13:antialias=true:hinting=true" ];
  };
}
