{ pkgs, config, lib, ... }:
with lib;
{
    options.secrets =
    {
      id_rsa = mkOption
      {
        type = types.string;
        description = "SSH RSA private key";
      };
    };
    config = 
    {
      secrets = import ../secret.nix;
    };
}
