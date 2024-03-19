{ config, pkgs, inputs, ... }:
{
  imports = [
    ./mako
    ./rofi
    ./waybar
    ./hyprland
  ];
}
