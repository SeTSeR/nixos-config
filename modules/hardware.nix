{ pkgs, config, lib, ... }:

let
  isVM = !isNull (builtins.match "^VirtualBox-.*" config.device);
in
{
  boot.loader = (if isVM then {
    grub.enable = true;
    grub.useOSProber = true;
    grub.efiSupport = false;
    grub.device = "/dev/sda";
  } else {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  });
  boot.initrd.checkJournalingFS = !isVM;
  
  # For Steam
  hardware.opengl.driSupport32Bit = true;

  hardware.pulseaudio = {
    enable = true;
    # For Steam
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };
  
  # For brightness control
  hardware.acpilight.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
}
