{ config, lib, ... }:
with lib; {
  options.secrets = {
    an_secret = mkOption {
      type = types.str;
      description = "Secret for Telegram proxy";
    };
    pr_secret = mkOption {
      type = types.str;
      description = "Secret for Telegram proxy";
    };
    stud-number = mkOption {
      type = types.str;
      description = "Student mail login";
    };
    stud-mail = mkOption {
      type = types.str;
      description = "CMC student mail";
    };
    gmail-mbsync-password = mkOption {
      type = types.str;
      description = "Password for mbsync";
    };
    stud-mail-password = mkOption {
      type = types.str;
      description = "Password for student mail";
    };
    outlook-mail-password = mkOption {
      type = types.str;
      description = "Password for outlook mail";
    };
    yandex-mail-password = mkOption {
      type = types.str;
      description = "Password for yandex mail";
    };
    org-gcal-client-id = mkOption {
      type = types.str;
      description = "Client ID for org-gcal";
    };
    org-gcal-client-secret = mkOption {
      type = types.str;
      description = "Client secret for org-gcal";
    };
  };
  config = { secrets = import ../secret.nix; };
}
