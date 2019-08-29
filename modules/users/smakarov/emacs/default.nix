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
          ace-jump-mode
          apropospriate-theme
          ccls
          company-lsp
          company-nixos-options
          company-racer
          counsel
          counsel-projectile
          diminish
          evil
          evil-magit
          flycheck
          flycheck-pkg-config
          flycheck-rust
          flyspell-correct
          free-keys
          google-c-style
          graphviz-dot-mode
          gruvbox-theme
          haskell-mode
          ivy
          ivy-yasnippet
          ix
          lsp-mode
          lsp-ui
          magit
          markdown-mode
          nix-mode
          powerline
          projectile
          racer
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
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/evil.el" = {
      text = readWithSubstitute ./evil.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/init.el" = {
      text = readWithSubstitute ./init.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/keys.el" = {
      text = readWithSubstitute ./keys.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/lsp.el" = {
      text = readWithSubstitute ./lsp.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/org.el" = {
      text = readWithSubstitute ./org.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/pivot-mode.el" = {
      text = readWithSubstitute ./pivot-mode.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/projectile.el" = {
      text = readWithSubstitute ./projectile.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/rust.el" = {
      text = readWithSubstitute ./rust.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/snippets.el" = {
      text = readWithSubstitute ./snippets.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/spell.el" = {
      text = readWithSubstitute ./spell.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/telega-settings.el" = {
      text = readWithSubstitute ./telega-settings.el;
      onChange = ''systemctl --user restart emacs'';
    };
    home.file.".emacs.d/yasnippet-snippets".source = ./yasnippet-snippets;
  };
}
