{ pkgs, lib, config, ... }: {
  networking = {
    networkmanager.enable = false;
    wireless = if config.deviceSpecific.isHomeMachine then {
      enable = true;
      userControlled.enable = true;
      networks = {
        "My Home net ASUS".psk = config.secrets.home-wifi-psk;
        AndroidAP_1361.psk = config.secrets.phone-psk;
        storm2.psk = config.secrets.work-psk;
        BMK_WIFI_FREE.psk = null;
      };
    } else {
      enable = false;
    };
    hostName = config.device;
    firewall = {
      allowedTCPPorts = [ 27015 26900 ];
      allowedUDPPorts = [ 27015 ];
    };
  };

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
