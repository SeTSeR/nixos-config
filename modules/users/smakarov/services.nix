{ config, pkgs, ... }: {
  home-manager.users.smakarov = {
    services.emacs.enable = true;
    services.udiskie = {
      enable = true;
      automount = false;
      notify = true;
      tray = "auto";
    };
    services.syncthing.enable = true;
  };
}

