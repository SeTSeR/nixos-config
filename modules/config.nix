{ config, lib, pkgs, ... }:
with lib; {
  options.openVPNConfigPath = mkOption {
    type = types.str;
    description = "Path to OpenVPN configuration";
  };

  options.emacsPackage = mkOption {
    type = types.package;
    description = "Emacs package to use";
  };

  config.openVPNConfigPath = "${config.users.users.smakarov.home}/.config/openvpn";
  config.emacsPackage = (pkgs.emacsPackagesNgGen pkgs.emacs).emacsWithPackages(epkgs:
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
      eshell-toggle
      epkgs.elpaPackages.exwm
      geiser
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
      notmuch
      epkgs.elpaPackages.org
      org-gcal
      org-ref
      pdf-tools
      epkgs.elpaPackages.pinentry
      powerline
      projectile
      racket-mode
      rainbow-delimiters
      reverse-im
      rust-mode
      smartparens
      symon
      quack
      telega
      use-package
      visual-fill-column
      wakatime-mode
      which-key
      yasnippet
      yasnippet-snippets
    ] ++
    [
      ((pkgs.emacsPackagesNgGen pkgs.emacs).melpaBuild {
        pname = "direnv";
        ename = "direnv";
        version = "20200818";
        recipe = pkgs.writeText "recipe" ''
          (direnv
            :fetcher github
            :repo "wbolster/emacs-direnv")
        '';
        src = pkgs.fetchFromGitHub {
          owner = "wbolster";
          repo = "emacs-direnv";
          rev = "e547e4b658dd3ac6110663109f94b9b05bd032a2";
          sha256 = "sha256-GGH1JbypThqVZmom3vLUGbqYdwx/8QsMU3mB/t0SKto=";
          fetchSubmodules = true;
        };
      })
    ]
  );
}
