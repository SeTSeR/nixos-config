{ config, pkgs, lib, ... }:
let readWithSubstitute = file:
      builtins.readFile (pkgs.substituteAll ((import ./subst.nix { inherit config pkgs lib; }) //
                                             { src = file; }));
      emacsWithImagemagick = (pkgs.emacsGit.override {
        srcRepo = true;
        imagemagick = pkgs.imagemagick7Big;
      });
in {
  home-manager.users.smakarov = {
    programs.emacs = {
      enable = true;
      package = emacsWithImagemagick;
      extraPackages = epkgs:
        with epkgs; [
          ace-window
          apropospriate-theme
          avy
          ccls
          company-irony
          company-lsp
          company-nixos-options
          counsel
          counsel-projectile
          dap-mode
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
          ix
          lsp-mode
          lsp-ui
          magit
          markdown-mode
          multitran
          nix-mode
          org-ref
          ox-textile
          pdf-tools
          powerline
          projectile
          rainbow-delimiters
          reverse-im
          russian-holidays
          rust-mode
          smartparens
          telega
          use-package
          visual-fill-column
          wakatime-mode
          yasnippet
          yasnippet-snippets
        ];
    };

    home.file.".authinfo.gpg".source = ./authinfo.gpg;
    home.file.".config/emacs/completion.el" = {
      text = readWithSubstitute ./completion.el;
    };
    home.file.".config/emacs/cpp.el" = {
      text = readWithSubstitute ./cpp.el;
    };
    home.file.".config/emacs/dap.el" = {
      text = readWithSubstitute ./dap.el;
    };
    home.file.".config/emacs/init.el" = {
      text = readWithSubstitute ./init.el;
    };
    home.file.".config/emacs/keys.el" = {
      text = readWithSubstitute ./keys.el;
    };
    home.file.".config/emacs/lsp.el" = {
      text = readWithSubstitute ./lsp.el;
    };
    home.file.".config/emacs/org.el" = {
      text = readWithSubstitute ./org.el;
    };
    home.file.".config/emacs/projectile.el" = {
      text = readWithSubstitute ./projectile.el;
    };
    home.file.".config/emacs/rust.el" = {
      text = readWithSubstitute ./rust.el;
    };
    home.file.".config/emacs/snippets.el" = {
      text = readWithSubstitute ./snippets.el;
    };
    home.file.".config/emacs/spell.el" = {
      text = readWithSubstitute ./spell.el;
    };
    home.file.".config/emacs/telega-settings.el" = {
      text = readWithSubstitute ./telega-settings.el;
    };
    home.file.".config/emacs/yasnippet-snippets".source = ./yasnippet-snippets;
    home.file.".gnus.el" = {
      text = readWithSubstitute ./gnus.el;
    };
  };
}
