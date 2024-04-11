{ config, pkgs, inputs, ... }:
{
  programs.waybar = {
    enable = true;
    style = ''
      * {
        font-family: UbuntuMono Nerd Font;
        font-size: 16px;
        background: transparent;
        color: white;
      }

      #waybar {
        /* :^) */
      }

      .modules-right {
        background-color: rgba(0,0,0,0.3);
        border: 2px solid #${config.colorScheme.palette.base0C};
        border-radius: 30px;
        padding: 2px 10px;
      }

      .modules-center {
        background-color: rgba(0,0,0,0.3);
        border: 2px solid #${config.colorScheme.palette.base0C};
        border-radius: 20px;
        padding: 2px 10px;
      }

      .modules-left {
        background-color: rgba(0,0,0,0.3);
        border: 2px solid #${config.colorScheme.palette.base0C};
        border-radius: 30px;
        padding: 2px 10px;
      }

      #workspaces button {
        padding: 0px 10px;
      }

      #workspaces button:hover {
        box-shadow: inherit;
      }

      #workspaces button:hover label {
        color: #${config.colorScheme.palette.base0B};
      }

      #workspaces button.active {
        box-shadow: inherit;
      }

      #workspaces button.active label {
        color: #${config.colorScheme.palette.base0A};
      }

      #hardware * {
        padding: 0px 10px;
      }

      #battery.empty {
        color: #f47174;
      }

      #battery.low {
        color: #fbe790;
      }

      #battery.charging {
        color: #acd1af;
      }

      #utility {
        padding: 2px 0px;
      }

      #utility * {
        padding: 2px 0px;
      }

      #clock {
        font-weight: bold;
      }
    '';
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 60;
        margin-top = 10;
        margin-left = 10;
        margin-right = 10;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "group/utility" ];
        modules-right = [ "group/hardware" ];
        "hyprland/workspaces" = {
          format = "<sub>{icon}</sub>\n{windows}";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
            "magic" = "零";
          };
          format-window-separator = "  ";
          window-rewrite-default = "";
          window-rewrite = {
            "class<firefox>" = "";
            "class<kitty>" = "";
            "class<kitty> title<.*ncspot.*>" = "";
            "class<VirtualBox Manager>" = "";
            "class<VirtualBox Machine> title<.*Ubuntu.*>" = "";
            "class<VirtualBox Machine> title<.*Windows.*>" = "";
          };
          on-click = "activate";
          disable-scroll = true;
          all-outputs = true;
          show-special = true;
        };
        "hyprland/window" = {
          max-length = 200;
          separate-outputs = true;
        };
        "clock" = {
          interval = 60;
          format = "{:%H:%M}";
        };
        "group/utility" = {
          orientation = "vertical";
          modules = [
            "clock"
            "hyprland/window"
          ];
        };
        "battery" = {
          states = {
            empty = 5;
            low = 25;
            mid = 50;
            high = 75;
            full = 100;
          };
          format = "<sub>{icon}</sub>\n{capacity}%";
          format-icons = { "default" = [ "" "" "" "" "" ]; };
        };
        "network" = {
          format = "{ifname}";
          format-wifi = "<sub></sub>\n{essid}";
          format-ethernet = "<sub></sub>\n{ipaddr}";
          format-disconnected = "<sub>X</sub>\nDisconnected";
          tooltip-format = "{ipaddr}";
          tooltip-disconnected = "Disconnected";
        };
        "hyprland/language" = {
          format = "{}";
          format-pl = "pl";
          format-de = "de";
          format-ru = "ru";
        };
        "group/hardware" = {
          orientation = "horizontal";
          modules = [
            "network"
            "hyprland/language"
            "battery"
          ];
        };
      };
    };
  };
}
