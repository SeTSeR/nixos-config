{ config, pkgs, ... }: {
  home-manager.users.smakarov.programs.gpg = {
    enable = true;
    settings = {
      use-agent = true;
    };
  };
}
