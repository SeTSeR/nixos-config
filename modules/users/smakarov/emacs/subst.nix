{ pkgs, config, ... }:
with import ../../../secrets.nix {};
rec {
  emacsConfigDir = "~/.config/emacs";
  bashPath = "${pkgs.bash}/bin/bash";
  notmuchPath = "${pkgs.notmuch}/bin/notmuch";
  notmuchrc = "/home/smakarov/.config/notmuch/notmuchrc";
  maildir = "/home/smakarov/Maildir";
  proxySecretOne = config.secrets.an_secret;
  proxySecretTwo = config.secrets.pr_secret;
  orgGcalClientId = config.secrets.org-gcal-client-id;
  orgGcalClientSecret = config.secrets.org-gcal-client-secret;
  userName = "smakarov";
}
