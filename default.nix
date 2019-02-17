# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

device:
{ config, pkgs, options, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./imports/home-manager/nixos
      ./modules
    ];
  inherit device;

  nixpkgs.overlays = [
    (import ./imports/nixpkgs-overlays)
  ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    networkmanager
    btrfs-progs
    gcc
    gdb
    pulseaudio
    sudo
    lightdm
    logmein-hamachi
    manpages
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ];
  
  # Enable Tor
  services.tor.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    dejavu_fonts
    liberation_ttf
    fira-code
    fira-code-symbols
    font-awesome_5
    ubuntu_font_family
    source-code-pro
  ];

  virtualisation.virtualbox.host.enable = true;

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

  users.mutableUsers = false;
  users.users.root.hashedPassword = "$6$I1DA5i2qtMUiZe$lhEzV/.ikRj.hRDBdUVN391VPCxsZWMUBgb.aKySTMa43VE2JmD/F8CvvgPy1cgesA7gEg9eFum6S9wxHxnu9.";

  security.sudo = {
    enable = true;
    extraConfig = ''
smakarov ALL = (root) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild switch
    '';
  };
 
  # For Steam
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

  # Enable automatic upgrades
  system.autoUpgrade.enable = true;

}
