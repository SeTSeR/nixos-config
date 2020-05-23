{ config, ... }:
{
  services.openvpn = {
    servers = {
      ispras-aviator = {
        autoStart = false;
        config = "config ${config.openVPNConfigPath}/aviator-dep-padaryan.conf";
        authUserPass = {
          username = config.secrets.isprasUserName;
          password = config.secrets.isprasPassword;
        };
        updateResolvConf = true;
      };
      ispras-bird = {
        autoStart = false;
        config = "config ${config.openVPNConfigPath}/bird.ovpn";
        authUserPass = {
          username = config.secrets.isprasUserName;
          password = config.secrets.isprasPassword;
        };
        updateResolvConf = true;
      };
    };
  };

  home-manager.users.smakarov.xdg.configFile."openvpn/bird.ovpn".source = ./openvpn/bird.ovpn;
  home-manager.users.smakarov.xdg.configFile."openvpn/aviator-dep-padaryan.conf".source = ./openvpn/aviator-dep-padaryan.conf;
  home-manager.users.smakarov.xdg.configFile."openvpn/ca-aviator.crt".source = ./openvpn/ca-aviator.crt;
  home-manager.users.smakarov.xdg.configFile."openvpn/ta-aviator.key".source = ./openvpn/ta-aviator.key;
}
