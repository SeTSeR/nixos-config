{ config, ... }: {
  home-manager.users.smakarov = {
    programs.mbsync.enable = true;
    programs.msmtp.enable = true;
    programs.notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
    };

    services.mbsync.enable = true;

    accounts.email.accounts = {
      main = {
        address = "setser200018@gmail.com";
        gpg = {
          key = "6AA23A1193B7064B";
          encryptByDefault = false;
          signByDefault = true;
        };
        imap = {
          host = "imap.gmail.com";
          port = 993;
          tls = {
            enable = true;
            useStartTls = false;
          };
        };
        mbsync = {
          enable = true;
          create = "maildir";
        };
        notmuch.enable = true;
        msmtp.enable = true;
        primary = true;
        passwordCommand = "echo '${config.secrets.gmail-mbsync-password}'";
        realName = "Sergey Makarov";
        signature = {
          text = ''
          С уважением,
          Макаров Сергей
          '';
          showSignature = "append";
        };
        smtp = {
          host = "smtp.gmail.com";
          port = 465;
          tls = {
            enable = true;
            useStartTls = false;
          };
        };
        userName = "setser200018@gmail.com";
      };

      cmc = {
        address = "${config.secrets.stud-number}@stud.cs.msu.ru";
        imap.host = "stud.cs.msu.ru";
        mbsync = {
          enable = true;
          create = "maildir";
        };
        passwordCommand = "echo '${config.secrets.stud-mail-password}'";
        realName = "Sergey Makarov";
        signature = {
          text = ''
          С уважением,
          Макаров Сергей, группа 527
          '';
          showSignature = "append";
        };
        smtp.host = "stud.cs.msu.ru";
        userName = "${config.secrets.stud-number}";
      };

      microsoft = {
        address = "setser2000@outlook.com";
        imap.host = "outlook.office365.com";
        mbsync = {
          enable = true;
          create = "maildir";
        };
        passwordCommand = "echo '${config.secrets.outlook-mail-password}'";
        realName = "Sergey Makarov";
        signature = {
          text = ''
          С уважением,
          Макаров Сергей
          '';
          showSignature = "append";
        };
        smtp = {
          host = "smtp.outlook.com";
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
        userName = "setser2000@outlook.com";
      };

      yandex = {
        address = "setser2000@setser.ru";
        imap.host = "imap.yandex.ru";
        mbsync = {
          enable = true;
          create = "maildir";
        };
        gpg = {
          key = "D7A0EAFC5EF2D54C";
          encryptByDefault = false;
          signByDefault = true;
        };
        passwordCommand = "echo '${config.secrets.yandex-mail-password}'";
        realName = "Sergey Makarov";
        signature = {
          text = ''
          С уважением,
          Макаров Сергей
          '';
          showSignature = "append";
        };
        smtp.host = "smtp.yandex.ru";
        msmtp.enable = true;
        userName = "setser2000";
      };
    };
  };
}
