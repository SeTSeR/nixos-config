{ config, pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    dejavu_fonts
    liberation_ttf
    fira-code
    fira-code-symbols
    font-awesome_5
    ubuntu_font_family
    source-code-pro
  ];
}
