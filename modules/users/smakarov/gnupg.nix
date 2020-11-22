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
      pinentryFlavor = "qt";
      extraConfig = ''
          allow-emacs-pinentry
              '';
    };
 };
}
