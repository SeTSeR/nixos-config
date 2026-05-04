# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:
let
  emacsPkg = (
    (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (
      epkgs: with epkgs; [
        async
        config.programs.ewm.ewmPackage
        eat
        edit-server
        ement
        gptel
        gptel-agent
        haskell-emacs
        haskell-mode
        journalctl-mode
        melpaPackages.telega
        nix-mode
        org
        pdf-tools
        rustic
        tree-sitter-langs
      ]
    )
  );
  sources = import ../npins;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    "${sources.ewm}/nix/service.nix"
    "${sources.sops-nix}/modules/sops"
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

  sops = {
    age = {
      generateKey = false;
      keyFile = "/var/lib/sops-nix/keys.txt";
    };
    secrets.wifi-conf = {
      format = "binary";
      owner = config.users.users.wpa_supplicant.name;
      group = config.users.users.wpa_supplicant.group;
      mode = "0444";
      restartUnits = [ "wpa_supplicant.service" ];
      sopsFile = ../secrets/wifi-mobile.conf;
    };
  };

  # Pick only one of the below networking options.
  networking = {
    wireless = {
      enable = true; # Enables wireless support via wpa_supplicant.
      extraConfigFiles = [ config.sops.secrets.wifi-conf.path ];
      secretsFile = config.sops.secrets.wifi-conf.path;
    };
    hostId = "fb0d0e1d";
    hostName = "main-pc";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";
  console = {
    font = "cyr-sun16";
    useXkbConfig = true;
  };

  nix = {
    channel.enable = false;
    nixPath = [ "nixpkgs=${sources.nixpkgs}" ];
    settings.trusted-users = [ "@wheel" ];
  };
  nixpkgs = {
    config.allowUnfree = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.meslo-lg
  ];

  hardware.acpilight.enable = true;

  # Enable OpenGL hardware acceleration.
  hardware.graphics.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  services.xserver.xkb = {
    layout = "us,ru";
    variant = ",winkeys";
    options = "ctrl:nocaps,grp:lctrl_toggle";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.whaleahead = {
    isNormalUser = true;
    extraGroups = [
      "dialout"
      "disk"
      "docker"
      "input"
      "kvm"
      "seat"
      "video"
      "wheel"
    ]; # Enable ‘run0’ for the user.
    packages = with pkgs; [
      amneziawg-tools
      bemenu
      emacsPkg
      ffmpeg-full
      firefox
      flameshot
      gajim
      git
      ifuse
      j4-dmenu-desktop
      kitty
      libimobiledevice
      poweralertd
      rdesktop
      swaylock
      wl-clipboard
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    (pkgs.writeShellApplication {
      name = "sudo";
      runtimeInputs = [ config.systemd.package ];
      text = ''exec run0 ${
        lib.concatMapStringsSep " " (var: "--setenv=${var}") [
          "PATH"
          "SHELL"
          "LOCALE_ARCHIVE"
          "TZDIR"
          "NIX_PATH"
          "EDITOR"
          "PAGER"
          "MANPAGER"
          "LESS"
          "LESSKEYIN_SYSTEM"
          "LESSOPEN"
          "SYSTEMD_LESS"
        ]
      } "$@"'';
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.ewm = {
    enable = true;
    emacsPackage = emacsPkg;
  };

  security = {
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };
    sudo.enable = false;
  };

  services.kmscon = {
    enable = false;
    fonts = [
      {
        name = "Iosevka";
        package = pkgs.iosevka;
      }
      {
        name = "Noto Fonts Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      }
      {
        name = "Meslo LG";
        package = pkgs.nerd-fonts.meslo-lg;
      }
    ];
    useXkbConfig = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.upower.enable = true;
  services.udisks2.enable = true;

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

  services.usbmuxd.enable = true;

  # List services that you want to enable:

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
