{ config, pkgs, lib, ... }:
{
  home-manager.users.smakarov.programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.Nix
      ms-vscode.cpptools
      ms-vscode-remote.remote-ssh
      Rubymaniac.vscode-direnv
      rust-lang.rust
      sjhuangx.vscode-scheme
      james-yu.latex-workshop
      vscode-org-mode.org-mode
      WakaTime.vscode-wakatime
      lucax88x.codeacejumper
      vscodevim.vim
    ];
    userSettings = {
      "update.mode" = "none";
      "[nix].editor.tabSize" = 2;
    };
  };
}
