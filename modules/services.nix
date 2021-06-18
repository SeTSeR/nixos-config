{ config, pkgs, lib, ... }: {
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  services.dbus = {
    enable = true;
  };
  services.earlyoom = {
    enable = true;
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

  # Enable Terraria server.
  services.terraria = {
    enable = false;
    autoCreatedWorldSize = "large";
    password = config.secrets.terraria-password;
    port = 7777;
    secure = false;
    worldPath = "/var/lib/terraria/Bad_Arbor_of_Birds.wld";
  };

  # Remap Ctrl and CapsLock
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.caps2esc ];
    udevmonConfig = ''
    - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
      DEVICE:
        EVENTS:
          EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable Tor
  services.tor.enable = false;

  services.blueman.enable = true;

  services.udisks2.enable = true;

  services.fstrim.enable = true;

  virtualisation.docker.enable = true;
}
