{ config, lib, ... }: {
  imports = [
    ./alacritty.nix
    ./emacs
    ./firefox.nix
    ./git.nix
    ./gnupg.nix
    ./i3
    ./mail.nix
    ./obs.nix
    ./openvpn.nix
    ./packages.nix
    ./services.nix
    ./smakarov.nix
    ./ssh.nix
    ./tmux.nix
    ./vim.nix
    ./vscode.nix
    ./zsh.nix
    ./xdg.nix
    ./xsession.nix
  ];
}
