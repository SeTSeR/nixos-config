{ config, lib, pkgs, ... }:
with lib;
let emacsWithPackages = {
      package ? pkgs.emacs,
        override ? (epkgs: epkgs),
        extraPackages ? epkgs: [],
    }:
      let emacsPackages = pkgs.emacsPackagesGen package;
      in emacsPackages.emacsWithPackages (epkgs:
        extraPackages (override epkgs)
      );
in {
  options.openVPNConfigPath = mkOption {
    type = types.str;
    description = "Path to OpenVPN configuration";
  };

  options.emacsPackage = mkOption {
    type = types.package;
    description = "Emacs package to use";
  };

  config.openVPNConfigPath = "${config.users.users.smakarov.home}/.config/openvpn";
  config.emacsPackage = emacsWithPackages {
    package = pkgs.emacsGit;
    override = epkgs: epkgs // {
      melpaPackages = epkgs.melpaPackages // {
        direnv = epkgs.melpaPackages.direnv.overrideAttrs(oldAttrs: {
          version = "20201207";
          recipe = pkgs.writeText "recipe" ''
          (direnv
            :fetcher github
            :repo "wbolster/emacs-direnv")
        '';
          src = pkgs.fetchFromGitHub {
            owner = "wbolster";
            repo = "emacs-direnv";
            rev = "57c86e46abbe57a2d36c8b4672dad55d4081ca74";
            sha256 = "sha256-lLvG6uFCU5uNTTfG4G3r8rl3ne06ndd2/sreAS0nelw=";
            fetchSubmodules = true;
          };
        });
      };
    };
    extraPackages = epkgs:
    (with epkgs.melpaPackages; [
      ace-window
      avy
      ccls
      diminish
      direnv
      eshell-toggle
      geiser
      flycheck
      flycheck-irony
      flycheck-pkg-config
      flycheck-rust
      flyspell-correct
      free-keys
      gcmh
      glsl-mode
      gnuplot
      google-c-style
      graphviz-dot-mode
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
      org-gcal
      org-ref
      pdf-tools
      powerline
      racket-mode
      rainbow-delimiters
      reverse-im
      rust-mode
      smartparens
      epkgs.melpaStablePackages.telega
      use-package
      visual-fill-column
      vterm
      wakatime-mode
      which-key
      yasnippet
      yasnippet-snippets
    ]) ++
    (with epkgs.elpaPackages; [
      exwm
      pinentry
    ]);
  };
}
