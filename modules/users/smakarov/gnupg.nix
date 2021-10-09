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
      sshKeys = [
        "9BDEE73D9C3BF46A833E71207C9F8FD1778B6008"
        "E55515079A1F1D827849C252AEF4F49DB09A90FC"
      ];
      pinentryFlavor = "qt";
    };
 };
}
