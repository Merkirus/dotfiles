# user.nix

{ lib, config, pkgs, ... }:

let
  cfg = config.user;
in
{
  options.user = {
    enable = lib.mkEnableOption "enable user module";
    userName = lib.mkOption {
      default = "frafau";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  };
}
