{ config, lib, ... }: {
  imports = [
    ./alacritty.nix
    ./emacs
    ./firefox.nix
    ./git.nix
    ./gnupg.nix
    ./i3
    ./openvpn.nix
    ./packages.nix
    ./services.nix
    ./smakarov.nix
    ./ssh.nix
    ./vim.nix
    ./zsh.nix
    ./xdg.nix
  ];
}
