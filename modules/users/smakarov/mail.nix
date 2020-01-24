{ pkgs, config, lib, ... }: {
  home-manager.users.smakarov = {
    programs = {
      mbsync.enable = true;
      msmtp.enable = true;
    };

    accounts.email.accounts = {
      gmail = {
        address = "setser200018@gmail.com";
        flavor = "gmail.com";
        gpg = {
          key = "0x6AA23A1193B7064B";
          encryptByDefault = false;
          signByDefault = true;
        };
        realName = "Sergey Makarov";
        passwordCommand = "echo ${config.secrets.mbsync-pass}";
        mbsync.enable = true;
        msmtp.enable = true;
        primary = true;
        signature = {
          text = ''
С уважением,
Макаров Сергей.
        '';
          showSignature = "append";
        };
      };

      ispras = {
        address = "smakarov@ispras.ru";
        gpg = {
          key = "0x630360E736884249";
          encryptByDefault = false;
          signByDefault = true;
        };
        realName = "Sergey Makarov";
        userName = "smakarov";
        passwordCommand = "${pkgs.bitwarden-cli}/bin/bw get password gitlab.ispras.ru";
        mbsync.enable = true;
        msmtp.enable = true;
        primary = false;

        imap = {
          host = "mail.ispras.ru";
          port = 993;
          tls = {
            enable = true;
            useStartTls = false;
          };
        };

        smtp = {
          host = "mail.ispras.ru";
          port = 465;
          tls = {
            enable = true;
            useStartTls = false;
          };
        };
      };

      stud-mail = {
        address = config.secrets.stud-mail;
        gpg = {
          encryptByDefault = false;
          signByDefault = true;
        };
        realName = "Sergey Makarov";
        userName = "smakarov";
        passwordCommand = "${pkgs.bitwarden-cli}/bin/bw get password webmail.cs.msu.ru";
        mbsync.enable = true;
        msmtp.enable = true;
        primary = false;

        imap = {
          host = "stud.cs.msu.ru";
          port = 993;
          tls = {
            enable = true;
            useStartTls = false;
          };
        };

        smtp = {
          host = "stud.cs.msu.ru";
          port = 465;
          tls = {
            enable = true;
            useStartTls = false;
          };
        };
      };
    };
  };
}
