# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  self,
  nixpkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    mirroredBoots = [
      {
        devices = [ "nodev" ];
        path = "/boot";
      }
    ];
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  networking = {
    wireless = {
      enable = true; # Enables wireless support via wpa_supplicant.
      secretsFile = "/home/wireless.env";
      networks."My Home net ASUS".psk = "LF73F4AS45MAIZDNACBN";
      networks."Galaxy S22 Ultra".psk = "blue2694";
    };
    hostId = "fb0d0e1d";
    hostName = "main-pc";
  };

  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";
  console.font = "Lat2-Terminus16";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [ "@wheel" ];
  nix.registry = {
    self.flake = self;
    np.flake = nixpkgs;
  };
  nixpkgs.config.allowUnfree = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Custom udev rules
  services.udev.extraRules = ''
    # USB-Blaster
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666", NAME="bus/usb/$env{BUSNUM}/$env{DEVNUM}", RUN+="${pkgs.coreutils}/bin/chmod 0666 %c"
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666", NAME="bus/usb/$env{BUSNUM}/$env{DEVNUM}", RUN+="${pkgs.coreutils}/bin/chmod 0666 %c"
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666", NAME="bus/usb/$env{BUSNUM}/$env{DEVNUM}", RUN+="${pkgs.coreutils}/bin/chmod 0666 %c"
    # USB-Blaster II
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666", NAME="bus/usb/$env{BUSNUM}/$env{DEVNUM}", RUN+="${pkgs.coreutils}/bin/chmod 0666 %c"
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666", NAME="bus/usb/$env{BUSNUM}/$env{DEVNUM}", RUN+="${pkgs.coreutils}/bin/chmod 0666 %c"
  '';

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts-emoji
    font-awesome
    nerd-fonts.meslo-lg
  ];

  hardware.acpilight.enable = true;

  # Enable OpenGL hardware acceleration.
  hardware.graphics.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.whaleahead = {
    isNormalUser = true;
    extraGroups = [
      "dialout"
      "wheel"
      "disk"
      "docker"
      "kvm"
      "video"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      tree
      ffmpeg-full
      nvtopPackages.amd
      rdesktop
      openmw
      git
      bemenu
      wl-clipboard
      flameshot
      mako
      swaylock
      s6
      s6-rc
      poweralertd
      kitty
      j4-dmenu-desktop
      ((emacsPackagesFor emacs-pgtk).emacsWithPackages (
        epkgs: with epkgs; [
          async
          nix-mode
          org
          rustic
          epkgs.melpaPackages.telega
          ement
          tree-sitter-langs
          vterm
        ]
      ))
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.steam.enable = true;
  programs.steam.package = pkgs.steam.override {
    extraLibraries = pkgs: [ pkgs.pkgsi686Linux.gperftools ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.waybar.enable = true;

  services.upower.enable = true;
  services.udisks2.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}
