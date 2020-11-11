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
          allow-emacs-pinentry
          pinentry-program ${pkgs.pinentry-qt}/bin/pinentry-qt
              '';
    };
 };
}
