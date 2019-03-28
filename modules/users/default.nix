{pkgs, config, ...}:
{
  imports = [
    ./smakarov
  ];

  users.mutableUsers = !config.deviceSpecific.isHomeMachine;
  users.users.root.hashedPassword = "$6$I1DA5i2qtMUiZe$lhEzV/.ikRj.hRDBdUVN391VPCxsZWMUBgb.aKySTMa43VE2JmD/F8CvvgPy1cgesA7gEg9eFum6S9wxHxnu9.";

  security.sudo = {
    enable = true;
    extraConfig = ''
smakarov ALL = (root) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild switch
    '';
  };
}
