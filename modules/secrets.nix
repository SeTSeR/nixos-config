{ config, lib, ... }:
with lib; {
  options.secrets = {
    id_rsa = mkOption {
      type = types.str;
      description = "SSH RSA private key";
    };
    home-wifi-psk = mkOption {
      type = types.str;
      description = "Home network wi-fi key";
    };
    phone-psk = mkOption {
      type = types.str;
      description = "Phone wi-fi key";
    };
    work-psk = mkOption {
      type = types.str;
      description = "Work wi-fi key";
    };
    isprasUserName = mkOption {
      type = types.str;
      description = "Username for ISP RAS OpenVPN server";
    };
    isprasPassword = mkOption {
      type = types.str;
      description = "Password for ISP RAS OpenVPN server";
    };
    an_secret = mkOption {
      type = types.str;
      description = "Secret for Telegram proxy";
    };
    pr_secret = mkOption {
      type = types.str;
      description = "Secret for Telegram proxy";
    };
    stud-mail = mkOption {
      type = types.str;
      description = "CMC student mail";
    };
  };
  config = { secrets = import ../secret.nix; };
}
