{ config, pkgs, inputs, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
  rofi-theme = {
  };
in
{
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      
    }
  '';
}
