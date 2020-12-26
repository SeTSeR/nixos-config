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
      gcmh
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
#      epkgs.elpaPackages.org
      org-gcal
      org-ref
      pdf-tools
      epkgs.elpaPackages.pinentry
      powerline
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
      vterm
      wakatime-mode
      which-key
      yasnippet
      yasnippet-snippets
    ] ++
    [
      ((pkgs.emacsPackagesNgGen pkgs.emacsGit).elpaBuild {
        pname = "org";
        ename = "org";
        version = "9.4.4";
        src = pkgs.fetchurl {
          url = "https://elpa.gnu.org/packages/org-9.4.4.tar";
          sha256 = "sha256-C2S4xqrVJXkg3grZkarAid3cQVTIq4LaEAOEDI1FqhY=";
        };
        packageRequires = [];
        meta = {
          homepage = "https://elpa.gnu.org/packages/org.html";
          license = lib.licenses.free;
        };
      })
    ] ++
    [
      ((pkgs.emacsPackagesNgGen pkgs.emacsGit).melpaBuild {
        pname = "direnv";
        ename = "direnv";
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
      })
    ]
  );
}
