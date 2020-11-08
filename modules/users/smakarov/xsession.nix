{ config, pkgs, ... }:
{
  home-manager.users.smakarov.xsession = {
    enable = true;
    initExtra = ''
${pkgs.xorg.xmodmap}/bin/xmodmap ${config.users.users.smakarov.home}/.Xmodmap
    '';
    windowManager.command = "exec ${config.emacsPackage}/bin/emacs --fullscreen";
  };
}
