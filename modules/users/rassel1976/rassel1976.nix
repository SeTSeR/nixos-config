{ pkgs, config, lib, ... }:
{
  # Set up the user
  users.users.rassel1976 = if config.deviceSpecific.isWorkMachine then {
    isNormalUser = true;
    home = "/home/rassel1976";
    description = "Nikita Golovanov";
    extraGroups = [ "networkmanager" ];
    hashedPassword = "BF985284FFDD3429B10EA7F6422FE1D248A5D4390DA37DA7A103CA54F8E739CE00B7EF1A6F8C579B281D34E4D22B908C72899399558D639A0CF85ED7260CE569";
  } else lib.mkForce {};

  systemd.services.home-manager-rassel1976.enable = if config.deviceSpecific.isWorkMachine then true
  else lib.mkForce false;
}
