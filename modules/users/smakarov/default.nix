{ config, lib, ... }: {
  imports = [
    ./emacs
    ./firefox.nix
    ./git.nix
    ./gnupg.nix
    ./mail.nix
    ./obs.nix
    ./openvpn.nix
    ./packages.nix
    ./services.nix
    ./smakarov.nix
    ./ssh.nix
    ./vim.nix
    ./vscode.nix
    ./zsh.nix
    ./xdg.nix
    ./xsession.nix
  ];
}
