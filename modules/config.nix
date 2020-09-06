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
      org-ref
      pdf-tools
      powerline
      projectile
      racket-mode
      rainbow-delimiters
      reverse-im
      rust-mode
      smartparens
      quack
      telega
      use-package
      visual-fill-column
      wakatime-mode
      yasnippet
      yasnippet-snippets
    ] ++
    [
      ((pkgs.emacsPackagesNgGen pkgs.emacs).melpaBuild {
        pname = "direnv";
        ename = "direnv";
        version = "20200905";
        recipe = pkgs.writeText "recipe" ''
          (direnv
            :fetcher github
            :repo "SeTSeR/emacs-direnv")
        '';
        src = pkgs.fetchFromGitHub {
          owner = "SeTSeR";
          repo = "emacs-direnv";
          rev = "dbd9802aab97cd79ac561400f2a115bef9835e79";
          sha256 = "sha256-OYJpK5xg8xmvTTJoPAXiHSQ9wqJ5tzcw2Pk0aWuMUL8=";
          fetchSubmodules = true;
        };
      })
    ]
  );
}
