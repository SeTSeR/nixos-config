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
  
  hardware = {
    # For Steam
    opengl.driSupport32Bit = true;
    pulseaudio = {
      enable = true;
      # For Steam
      support32Bit = true;
      # For bt headphones
      package = pkgs.pulseaudioFull;
    };
    acpilight.enable = true;
    bluetooth.enable = true;
  };
}
