{ config, pkgs, lib }:
{
  home-manager.users.smakarov.programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = [];
    userSettings = {
      "update.channel" = "none";
      "[nix].editor.tabSize" = 2;
    };
  };
}
