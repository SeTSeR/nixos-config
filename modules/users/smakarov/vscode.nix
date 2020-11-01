{ config, pkgs, lib, ... }:
{
  home-manager.users.smakarov.programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.Nix
      ms-vscode.cpptools
      ms-vscode-remote.remote-ssh
      Rubymaniac.vscode-direnv
      rust-lang.rust
      kahole.edamagit
      matklad.rust-analyzer
      sjhuangx.vscode-scheme
      tuttieee.emacs-mcx
      james-yu.latex-workshop
      vscode-org-mode.org-mode
      WakaTime.vscode-wakatime
    ];
    keybindings = [
      {
        key = "ctrl-x g";
        command = "magit.status";
      }
      {
        key = "ctrl-x ctrl-c";
        command = "workbench.action.quit";
      }
    ];
    userSettings = {
      "update.mode" = "none";
      "[nix].editor.tabSize" = 2;
      "org.todoKeywords" = [
        "TODO" "NEXT" "DONE" "WAITING" "HOLD" "CANCELLED"
      ];
      "emacs-mcx.strictEmacsMove" = true;
      "workbench.colorTheme" = "Solarized Light";
    };
  };
}
