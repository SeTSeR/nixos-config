{ config, pkgs, lib, ... }:
let emacsWithImagemagick = (pkgs.emacs.override {
      srcRepo = true;
      imagemagick = pkgs.imagemagickBig;
    });
    readWithSubstitute = file:
      builtins.readFile (pkgs.substituteAll ((import ./subst.nix { inherit config pkgs lib; }) //
                                             { src = file; }));
in {
  home-manager.users.smakarov = {
    programs.emacs = {
      enable = true;
      package = emacsWithImagemagick;
      extraPackages = epkgs:
        with epkgs; [
          avy
          apropospriate-theme
          ccls
          company-irony
          company-lsp
          company-nixos-options
          counsel
          counsel-projectile
          dap-mode
          diminish
          eshell-toggle
          flycheck
          flycheck-pkg-config
          flycheck-rust
          flycheck-irony
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
          nix-mode
          org-ref
          ox-textile
          pdf-tools
          powerline
          projectile
          quelpa
          quelpa-use-package
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
    home.file.".gnus.el" = {
      text = readWithSubstitute ./gnus.el;
    };
    home.file.".emacs.d/completion.el" = {
      text = readWithSubstitute ./completion.el;
    };
    home.file.".emacs.d/cpp.el" = {
      text = readWithSubstitute ./cpp.el;
    };
    home.file.".emacs.d/dap.el" = {
      text = readWithSubstitute ./dap.el;
    };
    home.file.".emacs.d/init.el" = {
      text = readWithSubstitute ./init.el;
    };
    home.file.".emacs.d/keys.el" = {
      text = readWithSubstitute ./keys.el;
    };
    home.file.".emacs.d/lsp.el" = {
      text = readWithSubstitute ./lsp.el;
    };
    home.file.".emacs.d/org.el" = {
      text = readWithSubstitute ./org.el;
    };
    home.file.".emacs.d/projectile.el" = {
      text = readWithSubstitute ./projectile.el;
    };
    home.file.".emacs.d/rust.el" = {
      text = readWithSubstitute ./rust.el;
    };
    home.file.".emacs.d/snippets.el" = {
      text = readWithSubstitute ./snippets.el;
    };
    home.file.".emacs.d/spell.el" = {
      text = readWithSubstitute ./spell.el;
    };
    home.file.".emacs.d/telega-settings.el" = {
      text = readWithSubstitute ./telega-settings.el;
    };
    home.file.".emacs.d/yasnippet-snippets".source = ./yasnippet-snippets;
  };
}
