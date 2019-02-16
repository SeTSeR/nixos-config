{ pkgs, config, lib, ... }:

let
  isVM = !isNull (builtins.match "^VirtualBox-.*" config.device);
in
{
  boot.loader = (if isVM then {
    grub.enable = true;
    grub.useOSProber = true;
    grub.efiSupport = true;
    grub.efiInstallAsRemovable = true;
    grub.device = "nodev";
  } else {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  });
  boot.initrd.checkJournalingFS = !isVM;
}
