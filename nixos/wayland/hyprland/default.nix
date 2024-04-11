{ config, pkgs, inputs, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    sleep 1
    ${pkgs.swww}/bin/swww img ${./wallpaper.png}
    ${pkgs.mako}/bin/mako
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.default;
    # xwayland.enable = true;

    plugins = [
      # inputs.hyprland-plugins.packages."${pkgs.system}".hyprtrails doesnt work?
    ];

    settings = {
      "plugin:hyprtrails" = {
        color = "rgba(ffaa00ff)";
      };
      exec-once = ''${startupScript}/bin/start'';
      monitor = [
        "eDP-1,1920x1080,0x0,1"
        "DP-2,3440x1440,1920x0,1"
        "HDMI-A-1,preferred,1920x0,1,mirror,eDP-1"
      ];
      env = "XCURSOR_SIZE,24";
      input = {
        kb_layout = "pl,de,ru";
	      kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          natural_scroll = "yes";
        };
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(${config.colorScheme.palette.base0C}ff)";
        "col.inactive_border" = "rgba(${config.colorScheme.palette.base00}ff)";
        layout = "dwindle";
        allow_tearing = false;
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(${config.colorScheme.palette.base01}ff)";
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        preserve_split = true;
	      force_split = 2;
	      smart_resizing = false;
      };
      master = {
        new_is_master = true;
      };
      gestures = {
        workspace_swipe = "off";
      };
      misc = {
        force_default_wallpaper = 0;
      };
      windowrule = [
        "float,^(pavucontrol)$"
        "float,^(.blueman-manager-wrapped)$"
        "float,^(thunar)$"
      ];
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, RETURN, exec, kitty"
        "$mainMod, Q, killactive,"
        "$mainMod, X, exit,"
        "$mainMod, F, exec, rofi -show drun -show-icons"
        "$mainMod, V, exec, [floating] kitty -e nmtui"
        "$mainMod, B, exec, blueman-manager"
        "$mainMod, N, exec, pavucontrol"
        "$mainMod, E, exec, thunar"
        "$mainMod, M, fullscreen,"
        "$mainMod, T, togglefloating,"
        "$mainMod, T, centerwindow,"
        "$mainMod, R, togglesplit,"

        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, J, movefocus, d"
        "$mainMod, K, movefocus, u"

        "$mainMod SHIFT, H, swapwindow, l"
        "$mainMod SHIFT, L, swapwindow, r"
        "$mainMod SHIFT, J, swapwindow, d"
        "$mainMod SHIFT, K, swapwindow, u"

        "$mainMod CTRL, H, movewindow, l"
        "$mainMod CTRL, L, movewindow, r"
        "$mainMod CTRL, J, movewindow, d"
        "$mainMod CTRL, K, movewindow, u"

        "$mainMod ALT, H, resizeactive, -10 0"
        "$mainMod ALT, L, resizeactive, 10 0"
        "$mainMod ALT, J, resizeactive, 0 10"
        "$mainMod ALT, K, resizeactive, 0 -10"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, left, workspace, e-1"
        "$mainMod, right, workspace, e+1"

        "$mainMod CTRL, left, movetoworkspace, e-1"
        "$mainMod CTRL, right, movetoworkspace, e+1"

        "$mainMod CTRL ALT, left, movetoworkspace, -1"
        "$mainMod CTRL ALT, right, movetoworkspace, +1"

        ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
        ", xf86audiolowervolume, exec, pamixer -d 10"
        ", xf86audioraisevolume, exec, pamixer -i 10"
        ", xf86audiomute, exec, pamixer --toggle-mute"
        ", xf86audiomicmute, exec, pamixer --default-source --toggle-mute"
        ", xf86monbrightnessup, exec, brightnessctl set 10%+"
        ", xf86monbrightnessdown, exec, brightnessctl set 10%-"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
