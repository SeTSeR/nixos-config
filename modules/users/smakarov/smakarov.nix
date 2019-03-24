{ pkgs, config, ... }:
{

  programs.zsh.enable = true;
  programs.adb.enable = true;
  # Set up the user
  users.users.smakarov = {
    isNormalUser = true;
    home = "/home/smakarov";
    description = "Sergey Makarov";
    extraGroups = [ "wheel" "networkmanager" "video" "libvirt" ];
    hashedPassword = "$6$bhfILKl6NKxZT25$wOQ0A9AtNYLCGLHcR4Bee7VBzYUusq4Af.DAL4Qr5c12JN3LBYH1PFtm.UvCcvXjZ1PbpuhGndnQCgbPaj/.C.";
    shell = pkgs.zsh;
  };

  home-manager.useUserPackages = true;
  home-manager.users.smakarov = {
    home.sessionVariables = {
      EDITOR = "vim";
    };
  };
}
