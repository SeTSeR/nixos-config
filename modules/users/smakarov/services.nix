{ config, pkgs, ... }: {
  home-manager.users.smakarov = {
    services.blueman-applet.enable = true;
    services.emacs.enable = true;
    services.udiskie = {
      enable = true;
      automount = false;
      notify = true;
      tray = "auto";
    };
    services.lorri.enable = true;
  };
}

