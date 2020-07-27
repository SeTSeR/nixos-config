{ pkgs, config, ... }:
with import ../../../secrets.nix {};
rec {
  emacsConfigDir = "~/.config/emacs";
  emacsWakatimeAPIKey = config.secrets.wakatime-api-key;
  proxySecretOne = config.secrets.an_secret;
  proxySecretTwo = config.secrets.pr_secret;
}
