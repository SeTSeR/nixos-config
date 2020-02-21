{ config, pkgs, ... }: {
  home-manager.users.smakarov = {
    programs.gpg = {
      enable = true;
      settings = {
        use-agent = true;
      };
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      extraConfig = ''
          pinentry-program /etc/profiles/per-user/smakarov/bin/pinentry-qt
              '';
    };
 };
}
