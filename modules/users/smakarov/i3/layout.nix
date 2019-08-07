{ config, pkgs, ... }: {
  home-manager.users.smakarov = {
    home.file.".screenlayouts/layout.sh".source = ./layout.sh;
  };
}
