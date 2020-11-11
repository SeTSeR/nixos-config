{ config, pkgs, ... }: {
  home-manager.users.smakarov = {
    services.udiskie = {
      enable = true;
      automount = false;
      notify = true;
      tray = "auto";
    };
    services.syncthing.enable = true;
  };
}

