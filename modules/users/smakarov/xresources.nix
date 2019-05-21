{ config, pkgs, ... }:
{
  home-manager.users.smakarov.xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "morhetz";
      repo = "gruvbox-contrib";
      rev = "edb3ee5f626cdfb250d5ab42c1f5ccb9f8050514";
      sha256 = "0n32s5var4xxwk3bwm70mwja0gy6vaj2awm6kji10yw3fpqgg7yh";
    } + "/xresources/gruvbox-dark.xresources"
  );
}
