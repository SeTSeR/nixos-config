{ pkgs, lib, config, ... }:
with lib;
with types;
{
  options = {
    device = mkOption { type = strMatching "[A-Za-z]*\-[A-Za-z]*"; };
  };
}
