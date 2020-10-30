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
      matklad.rust-analyzer
      sjhuangx.vscode-scheme
      james-yu.latex-workshop
      vscode-org-mode.org-mode
      WakaTime.vscode-wakatime
      vscodevim.vim
    ];
    userSettings = {
      "update.mode" = "none";
      "[nix].editor.tabSize" = 2;
      "vim.easymotion.enable" = "true";
    };
  };
}
