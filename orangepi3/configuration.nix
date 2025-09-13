# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ self, nixpkgs, config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  hardware.bluetooth.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ./overlay.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.registry = {
    self.flake = self;
    np.flake = nixpkgs;
  };

  networking.hostName = "orangepi3"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks."My Home net ASUS".psk = "LF73F4AS45MAIZDNACBN";
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.whaleahead = {
    isNormalUser = true;
    extraGroups = [ "dialout" "video" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      luakit
      tree
      screen
      dmenu
      dwm
      git
      wiringOP
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
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
  services.tailscale.enable = true;
  services.adguardhome.enable = true;
  services.xrdp.enable = true;
  services.zapret = {
    enable = true;
    params = [
      "--dpi-desync=fake,multidisorder"
      "--dpi-desync-fooling=md5sig"
      "--dpi-desync-split-pos=method+2"
      "--dpi-desync-fake-http=0x00000000"
    ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 53 80 ];
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

