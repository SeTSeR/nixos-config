{ config, pkgs, libs, ... }:
{
  home-manager.users.smakarov = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = epkgs: with epkgs; [
        use-package
        diminish
        nix-mode
        haskell-mode
        powerline
        magit
        gruvbox-theme
        wakatime-mode
        projectile
        irony
        flycheck
        flycheck-pkg-config
        graphviz-dot-mode
        markdown-mode
        company
        company-irony
        rust-mode
        flycheck-rust
        company-racer
        racer
        smartparens
        company-irony-c-headers
        rainbow-delimiters
        google-c-style
        lsp-mode
        lsp-ui
        company-lsp
        ccls
        helm
        reverse-im
        free-keys
      ];
    };
    home.file.".emacs.d/cpp.el".source=./cpp.el;
    home.file.".emacs.d/lldb-gud.el".source=./lldb-gud.el;
    home.file.".emacs.d/init.el".source=./init.el;
    home.file.".emacs.d/keys.el".source=./keys.el;
    home.file.".emacs.d/org.el".source=./org.el;
    home.file.".emacs.d/projectile.el".source=./projectile.el;
    home.file.".emacs.d/rust.el".source=./rust.el;
    home.file.".emacs.d/lsp.el".source=./lsp.el;
  };
}
