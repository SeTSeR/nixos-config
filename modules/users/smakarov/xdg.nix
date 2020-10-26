{ config, lib, ...}:
{
  home-manager.users.smakarov.xdg = {
    enable = true;
    mimeApps.enable = true;
    mimeApps.defaultApplications = {
      "text/html" = "firefox.desktop";
      "text/plain" = "emacs.desktop";
      "application/pdf" = "emacs.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
    userDirs.enable = true;
  };
}
