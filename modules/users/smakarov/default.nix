{ config, lib, ... }: {
  imports = [
    ./emacs
    ./firefox.nix
    ./git.nix
    ./gnupg.nix
    ./i3
    ./mail.nix
    ./packages.nix
    ./services.nix
    ./smakarov.nix
    ./ssh.nix
    ./vim.nix
    ./xdg.nix
    ./zsh.nix
  ];
}
