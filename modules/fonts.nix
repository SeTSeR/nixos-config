{ config, pkgs, ... }: {
  fonts = {
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Iosevka" ];
      };
    };
    fonts = with pkgs; [
      dejavu_fonts
      fira-code
      fira-code-symbols
      font-awesome_5
      iosevka
      liberation_ttf
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      powerline-fonts
      source-code-pro
      symbola
      ubuntu_font_family
    ];
  };
}
