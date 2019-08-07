{ config, pkgs, libs, ... }: {
  home-manager.users.smakarov = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = epkgs:
      with epkgs; [
        apropospriate-theme
        company
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
        free-keys
        gruvbox-theme
        ivy
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
        rust-mode
        smartparens
        use-package
        wakatime-mode
      ];
    };
    home.file.".emacs.d/evil.el".source = ./evil.el;
    home.file.".emacs.d/init.el".source = ./init.el;
    home.file.".emacs.d/keys.el".source = ./keys.el;
    home.file.".emacs.d/org.el".source = ./org.el;
    home.file.".emacs.d/projectile.el".source = ./projectile.el;
    home.file.".emacs.d/rust.el".source = ./rust.el;
    home.file.".emacs.d/lsp.el".source = ./lsp.el;
    home.file.".emacs.d/pivot-mode.el".source = ./pivot-mode.el;
  };
}
