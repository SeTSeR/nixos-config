{ config, ... }:
{
  services.openvpn = {
    servers = {
      ispras = {
        autoStart = config.deviceSpecific.isHomeMachine;
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
}