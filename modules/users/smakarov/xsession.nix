{ config, pkgs, ... }:
{
  home-manager.users.smakarov.xsession = {
    enable = true;
    initExtra = ''
${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER
${pkgs.xorg.xmodmap}/bin/xmodmap ${config.users.users.smakarov.home}/.Xmodmap
${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr

    '';
    windowManager.command = "exec dbus-launch --exit-with-session ${config.emacsPackage}/bin/emacs --fullscreen";
  };
}
