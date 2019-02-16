{ pkgs, config, lib, ... }:

with rec
{
  inherit (config) device;
};
{
  boot.loader = {
    systemd-boot.enable = (device == "ASUS-Laptop");
    efi.canTouchEfiVariables = true;
  } // (if device == "VirtualBox" then {
    grub.enable = true;
    grub.useOsProber = true;
    grub.efiSupport = true;
    grub.efiInstallAsRemovable = true;
    grub.device = "nodev";
  });
}
