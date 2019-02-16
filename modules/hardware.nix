{ pkgs, config, lib, ... }:

with rec
{
  inherit (config) device;
};
{
  boot.loader = {
    systemd-boot.enable = (device == "ASUS-Laptop");
    efi.canTouchEfiVariables = (device == "ASUS-Laptop");
  } // (if (!isNull (builtins.match "^VirtualBox-.*")) then {
    grub.enable = true;
    grub.useOSProber = true;
    grub.efiSupport = true;
    grub.efiInstallAsRemovable = true;
    grub.device = "nodev";
  } else {
  });
}
