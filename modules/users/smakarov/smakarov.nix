{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;

    promptInit = ''
      if [ "$TERM" != dumb ]; then
        autoload -U promptinit && promptinit && prompt walters
      fi

      # Disable color and theme in dumb terminals.
      if [[ "$TERM" == 'dumb' ]]; then
        zstyle ':prezto:*:*' color 'no'
        zstyle ':prezto:module:prompt' theme 'off'
      fi
    '';
  };
  # Set up the user
  users.users.smakarov = {
    isNormalUser = true;
    home = "/home/smakarov";
    description = "Sergey Makarov";
    extraGroups = [ "wheel" "networkmanager" "video" "storage" ];
    hashedPassword =
    "$6$bhfILKl6NKxZT25$wOQ0A9AtNYLCGLHcR4Bee7VBzYUusq4Af.DAL4Qr5c12JN3LBYH1PFtm.UvCcvXjZ1PbpuhGndnQCgbPaj/.C.";
    shell = pkgs.zsh;
  };

  home-manager.useUserPackages = true;
  home-manager.users.smakarov = {
    home.sessionVariables = {
      EDITOR = "${pkgs.emacs}/bin/emacsclient -c";
      RUST_SRC_PATH = "${pkgs.rustPlatform.rustcSrc}";
    };
  };
}
