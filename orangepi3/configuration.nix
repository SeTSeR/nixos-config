# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  self,
  nixpkgs,
  config,
  pkgs,
  ...
}:
let
  sources = import ../npins;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    "${sources.sops-nix}/modules/sops"
  ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  hardware.bluetooth.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;

  nix = {
    channel.enable = false;
    nixPath = [ "nixpkgs=${sources.nixpkgs}" ];
    settings.trusted-users = [ "@wheel" ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = import ./overlay.nix;
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
      sopsFile = ../secrets/wifi-home.conf;
    };
  };

  # Pick only one of the below networking options.
  networking = {
    wireless = {
      enable = true; # Enables wireless support via wpa_supplicant.
      extraConfigFiles = [ config.sops.secrets.wifi-conf.path ];
      secretsFile = config.sops.secrets.wifi-conf.path;
    };
    hostName = "orangepi3";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.whaleahead = {
    isNormalUser = true;
    extraGroups = [
      "dialout"
      "video"
      "wheel"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      amneziawg-tools
      dmenu
      dtach
      git
      luakit
      screen
      tree
      wiringOP
      ((emacsPackagesFor emacs-pgtk).emacsWithPackages (
        epkgs: with epkgs; [
          async
          ement
          melpaPackages.telega
          nix-mode
          org
          tree-sitter-langs
          vterm
        ]
      ))
    ];
  };

  security = {
    polkit.enable = true;
    sudo.enable = false;
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
  environment.etc."orangepi-release".text = "BOARD=orangepi3-h6";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.mosh = {
    enable = true;
    withUtempter = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
    extraSetFlags = [ "--advertise-routes=192.168.31.0/24" ];
  };
  services.adguardhome.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    53
    80
  ];
  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.checkReversePath = "loose";

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It’s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
