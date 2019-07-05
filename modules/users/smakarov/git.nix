{ config, pkgs, ... }: {
  home-manager.users.smakarov.programs.git = {
    enable = true;
    signing = {
      key = "3C0A077647B0C401F7821DE61CAD6E80CE0210A7";
      signByDefault = true;
    };
    userEmail = "smakarov@ispras.ru";
    userName = "Sergey Makarov";
  };
}
