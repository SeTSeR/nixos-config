{ pkgs, config, ... }:
{
  virtualisation.oci-containers.containers = {
    monica = {
      cmd = [ "-p 8080:80" ];
      image = "monicahq/monicahq";
    };
  };
}
