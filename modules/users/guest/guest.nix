{ pkgs, config, lib, ... }:
{
  # Set up the user
  users.users.guest = if config.deviceSpecific.isWorkMachine then {
    isNormalUser = true;
    home = "/home/guest";
    description = "Guest";
    extraGroups = [ "networkmanager" ];
    password = "";
    } else lib.mkForce {};
}
