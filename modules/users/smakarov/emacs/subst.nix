{ pkgs, config, ... }:
with import ../../../secrets.nix {};
rec {
  bashPath = "${pkgs.bash}/bin/bash";
  emacsConfigDir = "${config.home-manager.users.smakarov.xdg.configHome}/emacs";
  notmuchPath = "${pkgs.notmuch}/bin/notmuch";
  notmuchrc = "${config.home-manager.users.smakarov.xdg.configHome}/notmuch/notmuchrc";
  maildir = "${config.users.users.smakarov.home}/Maildir";
  proxySecretOne = config.secrets.an_secret;
  proxySecretTwo = config.secrets.pr_secret;
  orgGcalClientId = config.secrets.org-gcal-client-id;
  orgGcalClientSecret = config.secrets.org-gcal-client-secret;
  userName = "smakarov";
}
