{ config, pkgs, ... }: {
  home-manager.users.smakarov.programs.git = {
    enable = true;
    signing.signByDefault = true;
    signing.key = if config.deviceSpecific.isWorkMachine then "3C0A077647B0C401F7821DE61CAD6E80CE0210A7" else "0x29ED1FC2B32F2D88";
    userEmail = if config.deviceSpecific.isWorkMachine then "smakarov@ispras.ru" else "setser200018@gmail.com";
    userName = "Sergey Makarov";
  };
}
