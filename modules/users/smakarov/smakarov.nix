{ pkgs, config, ... }:
{
  # Set up the user
  users.users.smakarov = {
    isNormalUser = true;
    home = "/home/smakarov";
    description = "Sergey Makarov";
    extraGroups = [ "wheel" "networkmanager" "video" "libvirt" "virtualbox" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$bhfILKl6NKxZT25$wOQ0A9AtNYLCGLHcR4Bee7VBzYUusq4Af.DAL4Qr5c12JN3LBYH1PFtm.UvCcvXjZ1PbpuhGndnQCgbPaj/.C.";
  };

  home-manager.users.smakarov = {
    programs.home-manager.enable = true;
    home.sessionVariables.EDITOR = "vim-custom";
  };
}
