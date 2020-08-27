# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ "${inputs.nixpkgs}/nixos/modules/installer/scan/not-detected.nix" ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a15f3914-05a2-46b3-a0f0-42f4c9f65528";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."nixos".device = "/dev/disk/by-uuid/8a3f915c-0db8-4ce7-834a-e67e5441a8e1";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D8BC-94CE";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/9699a14b-19da-427b-9360-91df62371ba8"; }
    ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
