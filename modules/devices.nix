{ pkgs, lib, config, ... }:
with lib;
with types;
{
  options = {
    device = mkOption { type = strMatching "[A-Za-z]*\-[A-Za-z]*"; };
    deviceSpecific = mkOption { type = attrs; };
  };
  
  config = {
    deviceSpecific = let device = config.device;
    in rec {
      isHomeMachine = (device == "ASUS-Laptop");
    };
  };
}
