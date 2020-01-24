{ config, lib, ... }: {
  imports = [
    ./alacritty.nix
    ./emacs
    ./firefox.nix
    ./git.nix
    ./gnupg.nix
    ./i3
    ./mail.nix
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
