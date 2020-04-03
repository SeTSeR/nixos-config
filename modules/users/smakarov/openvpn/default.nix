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

  home-manager.users.smakarov.home.file.".config/openvpn/bird.ovpn".source = ./bird.ovpn;
  home-manager.users.smakarov.home.file.".config/openvpn/aviator-dep-padaryan.conf".source = ./aviator-dep-padaryan.conf;
  home-manager.users.smakarov.home.file.".config/openvpn/ca-aviator.crt".source = ./ca-aviator.crt;
  home-manager.users.smakarov.home.file.".config/openvpn/ta-aviator.key".source = ./ta-aviator.key;
}
