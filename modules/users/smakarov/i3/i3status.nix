{ config, pkgs, ... }: {
  home-manager.users.smakarov.xdg.configFile = {
    "i3status/config".text = ''
        general {
      	  output_format = "i3bar"
        }
        order += "wireless wlp2s0"
        order += "cpu_usage"
        order += "cpu_temperature 0"
        order += "disk /"
        order += "battery 0"
        order += "tztime local"
        order += "volume master"
        cpu_usage {
          format = "CPU: %usage"
        }
        cpu_temperature 0 {
          format = "T %degrees °C"
        }
        wireless wlp2s0 {
      	  format_up = "W: (%quality at %essid) %ip"
          format_down = "W: down"
        }
        battery 0 {
          format = "%status %percentage %remaining %emptytime"
          status_bat = "🔋"
          status_chr = "⚡"
          status_unk = "?"
          status_full = "☻"
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
