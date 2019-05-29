{ pkgs, config, lib, ... }:
with lib; {
  options.secrets = {
    id_rsa = mkOption {
      type = types.string;
      description = "SSH RSA private key";
    };
    home-wifi-psk = mkOption {
      type = types.string;
      description = "Home network wi-fi key";
    };
    phone-psk = mkOption {
      type = types.string;
      description = "Phone wi-fi key";
    };
    work-psk = mkOption {
      type = types.string;
      description = "Work wi-fi key";
    };
  };
  config = { secrets = import ../secret.nix; };
}
