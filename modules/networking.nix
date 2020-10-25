{ pkgs, lib, config, ... }: {
  networking = {
    networkmanager.enable = true;
    hostName = config.device;
    firewall = {
      allowedTCPPorts = [ 27015 26900 25565 7777 57621 4000 22000 ];
      allowedUDPPorts = [ 27015 25565 7777 22000 ];
    };
  };

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
