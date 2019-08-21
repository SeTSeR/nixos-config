{ config, pkgs, libs, ... }:
let emacsWithImagemagick = (pkgs.emacs.override {
    srcRepo = true;
    imagemagick = pkgs.imagemagickBig;
  });
in {
home-manager.users.smakarov = {
  programs.emacs = {
    enable = true;
    package = emacsWithImagemagick;
    extraPackages = epkgs:
    with epkgs; [
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
    home.file.".gnus.el".source = ./gnus.el;
    home.file.".emacs.d/completion.el".source = ./completion.el;
    home.file.".emacs.d/init.el".source = ./init.el;
    home.file.".emacs.d/keys.el".source = ./keys.el;
    home.file.".emacs.d/lsp.el".source = ./lsp.el;
    home.file.".emacs.d/org.el".source = ./org.el;
    home.file.".emacs.d/pivot-mode.el".source = ./pivot-mode.el;
    home.file.".emacs.d/projectile.el".source = ./projectile.el;
    home.file.".emacs.d/rust.el".source = ./rust.el;
    home.file.".emacs.d/snippets.el".source = ./snippets.el;
    home.file.".emacs.d/spell.el".source = ./spell.el;
    home.file.".emacs.d/telega-settings.el".source = ./telega-settings.el;
    home.file.".emacs.d/yasnippet-snippets".source = ./yasnippet-snippets;
  };
}
