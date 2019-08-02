{ config, lib, ... }:
with lib; {
  options.openVPNConfigPath = mkOption {
    type = types.string;
    description = "Path to OpenVPN configuration";
  };

  config.openVPNConfigPath = "${config.users.users.smakarov.home}/.config/openvpn";
}
