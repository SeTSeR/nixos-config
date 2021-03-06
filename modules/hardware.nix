{ pkgs, config, lib, ... }:

let isVM = !isNull (builtins.match "^VirtualBox-.*" config.device);
in {
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
    opengl = {
      enable = true;
      driSupport = true;
      # For Steam
      driSupport32Bit = true;
    };
    pulseaudio = {
      enable = true;
      # For Steam
      support32Bit = true;
      # For bt headphones
      package = pkgs.pulseaudioFull;
    };
  } // (if config.deviceSpecific.isHomeMachine then {
    acpilight.enable = true;
    bluetooth.enable = true;
    cpu.intel.updateMicrocode = true;
  } else (if config.deviceSpecific.isWorkMachine then {
    cpu.amd.updateMicrocode = true;
  } else {}));
}
