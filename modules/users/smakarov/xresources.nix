{ config, pkgs, ... }:
{
  home-manager.users.smakarov.xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "morhetz";
      repo = "gruvbox-contrib";
      rev = "025ceddbddf55f2eb4ab40b05889148aab9699fc";
      sha256 = "0n32s5var4xxwk3bwm70mwja0gy6vaj2awm6kji10yw3fpqgg7yh";
    } + "/xresources/gruvbox-dark.xresources"
  );
}
