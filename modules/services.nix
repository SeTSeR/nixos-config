{ config, pkgs, ... }:
{
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ];
  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us,ru(winkeys)";
    xkbOptions = "grp:caps_toggle";
    libinput.enable = true;
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };

  # Enable hamachi
  services.logmein-hamachi.enable = true;

  # Activate D-Bus socket
  services.dbus.socketActivated = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable Tor
  services.tor.enable = true;
}
