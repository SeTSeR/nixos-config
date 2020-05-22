{ config, pkgs, lib, ... }:
let readWithSubstitute = file:
      builtins.readFile (pkgs.substituteAll ((import ./subst.nix { inherit config pkgs lib; }) //
                                             { src = file; }));
      emacsWithImagemagick = (pkgs.emacsGit.override {
        srcRepo = true;
        imagemagick = pkgs.imagemagick7Big;
      });
      modulePaths = dir: map (fname: dir + "/${fname}") (builtins.attrNames (builtins.readDir dir));
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
        ];
    };

    home.file.".config/emacs/init.el".text =
      readWithSubstitute ./init.el
      + lib.concatStringsSep "\n" (map readWithSubstitute (modulePaths ./modules));
    home.file.".config/emacs/yasnippet-snippets".source = ./yasnippet-snippets;
  };
}
