{ pkgs, config, ... }:
with import ../../../secrets.nix {};
rec {
  emacsConfigDir = "~/.config/emacs";
  acpilightPath = "${pkgs.acpilight}/bin/xbacklight";
  flameshotPath = "${pkgs.flameshot}/bin/flameshot";
  pactlPath = "${pkgs.pulseaudio}/bin/pactl";
  playerctlPath = "${pkgs.playerctl}/bin/playerctl";
  proxySecretOne = config.secrets.an_secret;
  proxySecretTwo = config.secrets.pr_secret;
  orgGcalClientId = config.secrets.org-gcal-client-id;
  orgGcalClientSecret = config.secrets.org-gcal-client-secret;
  userName = "smakarov";
}
