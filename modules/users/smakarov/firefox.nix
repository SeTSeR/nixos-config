{ config, pkgs, ... }: {
  home-manager.users.smakarov.programs.firefox = {
    enable = true;
    enableAdobeFlash = false;
    extensions = with pkgs; [
      bitwarden
      treestyletab
      tridactyl
      ublock
      umatrix
    ];
    profiles.sswwt6ru = {
      id = 0;
      isDefault = true;
      name = "default";
      settings = {
        "toolkit.telemetry.enabled" = "false";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = "true";
        "app.update.mode" = 1;
        "browser.search.defaultenginename" = "Google";
        "browser.search.selectedEngine" = "Google";
        "browser.uidensity" = 1;
        "browser.search.openintab" = true;
        "extensions.pocket.enabled" = false;
        "browser.safebrowsing.enabled" = true;
        "extensions.update.enabled" = false;
        "xpinstall.signatures.required" = false;
      };
      userChrome = ''
               /* Hide tab bar in FF Quantum */
               @-moz-document url("chrome://browser/content/browser.xhtml") {
                 #TabsToolbar {
                   visibility: collapse !important;
                   margin-bottom: 21px !important;
                   border-style: 0px !important;
                 }
               }
      '';
    };
  };
}
