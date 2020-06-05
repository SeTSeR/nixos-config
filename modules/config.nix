{ config, lib, pkgs, ... }:
with lib; {
  options.openVPNConfigPath = mkOption {
    type = types.str;
    description = "Path to OpenVPN configuration";
  };

  options.emacsPackage = mkOption {
    type = types.package;
    description = "Emacs package to use";
  };

  config.openVPNConfigPath = "${config.users.users.smakarov.home}/.config/openvpn";
  config.emacsPackage = pkgs.emacsGit;
}
