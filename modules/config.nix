{ config, lib, pkgs, ... }:
let telega = pkgs.emacs-overlay-pinned.emacsPackages.melpaPackages.telega;
in with lib; {
  options.openVPNConfigPath = mkOption {
    type = types.str;
    description = "Path to OpenVPN configuration";
  };

  options.emacsPackage = mkOption {
    type = types.package;
    description = "Emacs package to use";
  };

  config.openVPNConfigPath = "${config.users.users.smakarov.home}/.config/openvpn";
  config.emacsPackage = (pkgs.emacsPackagesNgGen pkgs.emacsGit).emacsWithPackages(epkgs:
  with epkgs.melpaPackages; [
    ace-window
    apropospriate-theme
    avy
    ccls
    company-irony
    company-lsp
    company-nixos-options
    counsel
    counsel-projectile
    diminish
    direnv
    eshell-toggle
    flycheck
    flycheck-irony
    flycheck-pkg-config
    flycheck-rust
    flyspell-correct
    free-keys
    glsl-mode
    gnuplot
    google-c-style
    graphviz-dot-mode
    gruvbox-theme
    haskell-mode
    irony
    ivy
    ivy-bibtex
    ivy-xref
    ivy-yasnippet
    lsp-mode
    lsp-ui
    magit
    markdown-mode
    multitran
    nix-mode
    org-ref
    pdf-tools
    powerline
    projectile
    rainbow-delimiters
    reverse-im
    rust-mode
    smartparens
    telega
    use-package
    visual-fill-column
    wakatime-mode
    yasnippet
    yasnippet-snippets
  ]);
}
