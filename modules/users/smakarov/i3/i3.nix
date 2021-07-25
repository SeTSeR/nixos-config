{ config, pkgs, lib, ... }:
{
  home-manager.users.smakarov.xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      assigns = {
        "1: " = [ { class = "^Chromium"; } { class = "^Firefox"; } ];
        "2: " = [{ class = "urxvt"; } { class = "alacritty"; }];
        "3: " = [
          {
            class = "^Telegram";
          }
          {
            class = "^VK";
          }
          {
            class = "^Discord";
          }
          {
            class = "^Mail";
          }
        ];
        "5: " = [{ class = "Steam"; }];
      };
      bars = [{
        fonts = {
          names = [ "FontAwesome" "Ubuntu Mono" ];
          size = 12.;
        };
        statusCommand = "${pkgs.i3status}/bin/i3status";
        position = "top";
        workspaceNumbers = false;
      }];
      fonts = {
        names = [ "DejaVu Sans Mono 8" ];
        size = 12.;
      };
      focus.followMouse = false;
      modifier = "Mod4";
      floating.modifier = "${modifier}";
      window = {
        border = 1;
        titlebar = false;
        commands = [{
          command = "move to workspace 4: ";
          criteria = { class = "Spotify"; };
        }];
      };
      startup = [
        { command = "${config.users.users.smakarov.home}/.screenlayouts/layout.sh"; }
        { command = "${pkgs.nitrogen}/bin/nitrogen --restore"; }
        { command = "${config.emacsPackage}/bin/emacs --fullscreen"; }
        { command = "${pkgs.firefox}/bin/firefox"; }
        { command = "${pkgs.spotify}/bin/spotify"; }
      ];
      keybindings = ({
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+l" = "layout toggle";
        "${modifier}+Left" = "focus child; focus left";
        "${modifier}+Down" = "focus child; focus down";
        "${modifier}+Up" = "focus child; focus up";
        "${modifier}+Right" = "focus child; focus right";
        "${modifier}+Ctrl+Left" = "focus parent; focus left";
        "${modifier}+Ctrl+Down" = "focus parent; focus down";
        "${modifier}+Ctrl+Up" = "focus parent; focus up";
        "${modifier}+Ctrl+Right" = "focus parent; focus right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";
        "${modifier}+Shift+e" = "exec ${pkgs.i3}/bin/i3-msg exit";
        "${modifier}+1" = "workspace 1: ";
        "${modifier}+2" = "workspace 2: ";
        "${modifier}+3" = "workspace 3: ";
        "${modifier}+4" = "workspace 4: ";
        "${modifier}+5" = "workspace 5: ";
        "${modifier}+Shift+1" = "move container to workspace 1: ";
        "${modifier}+Shift+2" = "move container to workspace 2: ";
        "${modifier}+Shift+3" = "move container to workspace 3: ";
        "${modifier}+Shift+4" = "move container to workspace 4: ";
        "${modifier}+Shift+5" = "move container to workspace 5: ";
        "${modifier}+Ctrl+l" = "exec ${pkgs.i3lock}/bin/i3lock";
        "${modifier}+Ctrl+p" = "exec ${config.emacsPackage}/bin/emacsclient -nc";
        "${modifier}+Ctrl+f" = "exec ${pkgs.firefox}/bin/firefox";
        "Ctrl+backslash" = "exec ${pkgs.xkb-switch}/bin/xkb-switch -n";
        "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioRaiseVolume" =
        "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" =
        "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 -5%";
        "XF86AudioMute" =
        "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute 0 toggle";
        "XF86MonBrightnessUp" =
        "exec ${pkgs.acpilight}/bin/xbacklight -ctrl intel_backlight -inc 20";
        "XF86MonBrightnessDown" =
        "exec ${pkgs.acpilight}/bin/xbacklight -ctrl intel_backlight -dec 20";
        "XF86KbdBrightnessUp" =
        "exec ${pkgs.acpilight}/bin/xbacklight -ctrl asus::kbd_backlight -inc 20";
        "XF86KbdBrightnessDown" =
        "exec ${pkgs.acpilight}/bin/xbacklight -ctrl asus::kbd_backlight -dec 20";
        "--release Print" = ''
          exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui'';
      } // builtins.listToAttrs (builtins.genList (x: {
        name = "${modifier}+${toString (x + 6)}";
        value = "workspace ${toString (x + 6)}";
      }) 4) // builtins.listToAttrs (builtins.genList (x: {
        name = "${modifier}+Shift+${toString (x + 6)}";
        value = "move container to workspace ${toString (x + 6)}";
      }) 4));
      workspaceLayout = "tabbed";
    };
    extraConfig = if config.deviceSpecific.isWorkMachine then ''
      workspace "1: " output HDMI-0
      workspace "2: " output primary
      workspace "3: " output HDMI-0
      workspace "4: " output primary
    '' else "";
  };
}
