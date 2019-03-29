{ config, pkgs, ... }:
{
  home-manager.users.guest.xdg.configFile = {
    "i3status/config".text = ''
  general {
	  output_format = "i3bar"
  }

  order += "disk /"
  order += "battery 0"
  order += "tztime local"
  order += "volume master"

  wireless iwm0 {
	  format_up = "W: (%quality at %essid) %ip"
    format_down = "W: down"
  }

  battery 0 {
    format = "%status %percentage %remaining %emptytime"
  }

  tztime local {
    format = "%Y-%m-%d %H:%M:%S"
  }

  disk "/" {
    format = "%free"
  }

  volume master {
    format = "♪: %volume"
    format_muted = "♪: muted (%volume)"
    device = "default"
    mixer = "Master"
    mixer_idx = 0
  }
    '';
  };
}
