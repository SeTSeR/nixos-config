{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    signing = {
      key = "6F8A18AE4101103F3C5424B96AA23A1193B7064B";
      signByDefault = true;
    };
    userEmail = "setser200018@gmail.com";
    userName = "Sergey Makarov";
  };
}
