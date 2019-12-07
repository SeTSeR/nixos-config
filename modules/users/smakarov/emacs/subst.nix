{ config, ... }:
with import ../../../secrets.nix {};
rec {
  proxySecretOne = config.secrets.an_secret;
  proxySecretTwo = config.secrets.pr_secret;
}
