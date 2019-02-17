{ pkgs, config, ... }:
let term = "${pkgs.rxvt_unicode}/bin/urxvt";
in
{
  home-manager.users.smakarov.xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      assigns = {
        "1: " = [ { class = "Chromium"; } { class = "Firefox"; } ];
        "2: " = [ { class = "urxvt"; } ];
        "3: " = [ { class = "Steam"; } ];
        "5: " = [ { class = "^Telegram"; } { class = "^VK"; } { class = "^Discord"; } ];
      };
      bars = [
        {
          fonts = [ "FontAwesome 10" "Ubuntu Mono 10" ];
          statusCommand = "${pkgs.i3status}/bin/i3status";
          position = "top";
          workspaceNumbers = false;
        }
      ];
      fonts = [ "DejaVu Sans Mono 8" ];
      focus.followMouse = false;
      modifier = "Mod4";
      floating.modifier = "${modifier}";
      window = {
        border = 1;
        titlebar = false;
        commands = [
          {
            command = "move to workspace 4: ";
            criteria = { class = "Spotify"; };
          }
        ];
      };
      startup = [
        { command = "${pkgs.nitrogen}/bin/nitrogen --restore"; notification = false; }
        { command = "${pkgs.spotify}/bin/spotify"; }
        { command = "${pkgs.tdesktop}/bin/telegram-desktop"; }
        { command = "${pkgs.vk-messenger}/bin/vk"; }
      ];
      keybindings = ({
        "${modifier}+Shift+q" = "kill";
        "${modifier}+Return" = "exec --no-startup-id ${term}";
        "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+l" = "layout toggle";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";
        "${modifier}+Shift+e" = "exec ${pkgs.i3}/bin/i3-msg exit";
        "${modifier}+1" = "workspace 1: ";
        "${modifier}+2" = "workspace 2: ";
        "${modifier}+3" = "workspace 3: ";
        "${modifier}+4" = "workspace 4: ";
        "${modifier}+5" = "workspace 5: ";
        "${modifier}+Shift+1" = "move container to workspace 1: ";
        "${modifier}+Shift+2" = "move container to workspace 2: ";
        "${modifier}+Shift+3" = "move container to workspace 3: ";
        "${modifier}+Shift+4" = "move container to workspace 4: ";
        "${modifier}+Shift+5" = "move container to workspace 5: ";
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 -5%";
        "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute 0 toggle";
        "XF86MonBrightnessUp" = "exec ${pkgs.acpilight}/bin/xbacklight -ctrl intel_backlight -inc 20";
        "XF86MonBrightnessDown" = "exec ${pkgs.acpilight}/bin/xbacklight -ctrl intel_backlight -dec 20";
        "XF86KbdBrightnessUp" = "exec ${pkgs.acpilight}/bin/xbacklight -ctrl asus::kbd_backlight -inc 20";
        "XF86KbdBrightnessDown" = "exec ${pkgs.acpilight}/bin/xbacklight -ctrl asus::kbd_backlight -dec 20";
        "--release Print" = "exec --no-startup-id \"import png:- | xclip -selection c -t image/png\"";
      } // builtins.listToAttrs (
        builtins.genList (x: {name = "${modifier}+${toString (x + 6)}"; value = "workspace ${toString (x + 6)}";}) 4
      ) // builtins.listToAttrs (
        builtins.genList (x: {name = "${modifier}+Shift+${toString (x + 6)}"; value = "move container to workspace ${toString (x + 6)}";}) 4
      ));
      workspaceLayout = "tabbed";
    };
  };
}
