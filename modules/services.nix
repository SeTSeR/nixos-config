{ config, pkgs, lib, ... }: {
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf pkgs.blueman ];
  systemd.coredump = {
    extraConfig = "Storage=journal";
  };
  security.pam.loginLimits = [{
    domain = "smakarov";
    type = "soft";
    item = "core";
    value = 1024;
  }];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  services.blueman.enable = true;

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

  # Activate D-Bus socket
  services.dbus.socketActivated = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable Tor
  services.tor.enable = false;

  services.udisks2.enable = true;

  services.postgresql = {
    enable = config.deviceSpecific.isHomeMachine;
    ensureDatabases = [ "autocorp_analytic" ];
    ensureUsers = [
      {
        name = "smakarov";
        ensurePermissions = {
          "DATABASE autocorp_analytic" = "ALL PRIVILEGES";
        };
      }
    ];
    package = pkgs.postgresql_11;
  };
}
