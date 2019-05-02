{ config, pkgs, libs, ... }:
{
  home-manager.users.smakarov = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = epkgs: with epkgs; [
        use-package
        ace-jump-mode
        diminish
        nix-mode
        nixos-options
        haskell-mode
        powerline
        magit
        solarized-theme
        dracula-theme
        gruvbox-theme
        evil
        wakatime-mode
        projectile
        irony
        flycheck
        flycheck-pkg-config
        auto-indent-mode
        markdown-mode
        company
        company-irony
        rust-mode
        flymake-rust
        racer
        evil-tabs
        smartparens
        company-irony-c-headers
        rainbow-delimiters
        google-c-style
      ];
    };
    home.file.".emacs.d/cpp.el".source=./cpp.el;
    home.file.".emacs.d/lldb-gud.el".source=./lldb-gud.el;
    home.file.".emacs.d/init.el".source=./init.el;
    home.file.".emacs.d/keys.el".source=./keys.el;
    home.file.".emacs.d/org.el".source=./org.el;
    home.file.".emacs.d/projectile.el".source=./projectile.el;
    home.file.".emacs.d/rust.el".source=./rust.el;
  };
}
