{ pkgs, config, ... }: {
  programs.adb.enable = true;
  programs.zsh.enable = true;
  # Set up the user
  users.users.smakarov = {
    isNormalUser = true;
    home = "/home/smakarov";
    description = "Sergey Makarov";
    extraGroups = [ "wheel" "networkmanager" "video" "storage" "docker" "terraria" "adbusers" ];
    hashedPassword =
    "$6$bhfILKl6NKxZT25$wOQ0A9AtNYLCGLHcR4Bee7VBzYUusq4Af.DAL4Qr5c12JN3LBYH1PFtm.UvCcvXjZ1PbpuhGndnQCgbPaj/.C.";
    shell = pkgs.zsh;
  };

  home-manager.useUserPackages = true;
  home-manager.users.smakarov = {
    programs.command-not-found = {
      enable = true;
      dbPath = ../../../misc/programs.sqlite;
    };
    systemd.user.startServices = true;
  };
  home-manager.users.smakarov.home = {
    homeDirectory = "/home/smakarov";
    username = "smakarov";
    file.".Xmodmap".text = ''
    keysym Alt_R = Multi_key Alt_R
    '';
    sessionVariables = {
      EDITOR = "${config.emacsPackage}/bin/emacsclient -c";
      VISUAL = "${config.emacsPackage}/bin/emacsclient -c";
      NIX_AUTO_RUN = "1";
    };
    keyboard = {
      layout = "us,ru(winkeys)";
      options = [ ",grp:win_space_toggle" ];
    };
    activation."mimeapps-remove" = {
      before = [ "linkGeneration" ];
      after = [];
      data = "rm -f /home/smakarov/.config/mimeapps.list";
    };
    stateVersion = "20.09";
  };
}
