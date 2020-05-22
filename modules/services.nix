{ config, pkgs, lib, ... }: {
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  services.dbus = {
    enable = true;
    socketActivated = true;
  };
  systemd.coredump = {
    extraConfig = "Storage=journal";
  };
  security.pam.loginLimits = [{
    domain = "smakarov";
    type = "soft";
    item = "core";
    value = 1024;
  }];

  sound.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us,ru(winkeys)";
    xkbOptions = "grp:caps_toggle";
    libinput.enable = true;
    displayManager.lightdm.enable = true;
    videoDrivers = lib.optionals config.deviceSpecific.isWorkMachine [ "nvidia" ];
    windowManager.i3.enable = true;
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable Tor
  services.tor.enable = false;

  services.udisks2.enable = true;

  services.fstrim.enable = true;
}
