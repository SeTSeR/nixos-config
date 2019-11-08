{ pkgs, lib, config, ... }: {
  networking = {
    networkmanager.enable = true;
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
