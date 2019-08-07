{ config, lib, ... }: {
  imports = [
    ./alacritty.nix
    ./emacs
    ./firefox.nix
    ./git.nix
    ./i3
    ./openvpn
    ./packages.nix
    ./services.nix
    ./smakarov.nix
    ./ssh.nix
    ./xresources.nix
    ./vim.nix
    ./zsh.nix
  ];
}
