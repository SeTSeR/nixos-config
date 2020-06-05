{ pkgs, config, ... }: {
  programs.zsh.enable = true;
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
      EDITOR = "${config.emacsPackage}/bin/emacsclient -c";
      VISUAL = "${config.emacsPackage}/bin/emacsclient -c";
      NIX_AUTO_RUN = "1";
      XKB_DEFAULT_LAYOUT = "us,ru(winkeys)";
      XKB_DEFAULT_OPTIONS = "grp:caps_toggle";
    };
    home.keyboard = {
      layout = "us,ru(winkeys)";
      options = [ "grp:caps_toggle" ];
    };
  };
}
