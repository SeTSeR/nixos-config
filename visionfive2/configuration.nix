# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, self, nixpkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  hardware.deviceTree.name = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";

  networking.hostName = "visionfive2"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  nixpkgs.overlays = [ (import ./overlay.nix) ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = {
    system = "riscv64-linux";
    rustc.config = "riscv64gc-unknown-linux-gnu";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.registry = {
    self.flake = self;
    np.flake = nixpkgs;
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.whaleahead = {
    isNormalUser = true;
    extraGroups = [ "video" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      screen
      dwm
      dmenu
      rtorrent
      git
      verilog
      nethack
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

  programs.mosh = {
    enable = true;
    withUtempter = true;
  };

  # List services that you want to enable:

  # Enable graphics support
  hardware.graphics.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # services.tailscale.enable = true;

  networking.wireless = {
    enable = true;
    networks."My Home net ASUS".psk = "LF73F4AS45MAIZDNACBN";
  };

  fonts.fontconfig.enable = false;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 2234 ];
  # networking.firewall.allowedUDPPorts = [ ...  ];
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
