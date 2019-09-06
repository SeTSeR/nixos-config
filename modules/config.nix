{ config, lib, ... }:
with lib; {
  options.openVPNConfigPath = mkOption {
    type = types.str;
    description = "Path to OpenVPN configuration";
  };

  config.openVPNConfigPath = "${config.users.users.smakarov.home}/.config/openvpn";
}
