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
      sshKeys = [ "9BDEE73D9C3BF46A833E71207C9F8FD1778B6008" ];
      pinentryFlavor = "qt";
      extraConfig = ''
          allow-emacs-pinentry
              '';
    };
 };
}
