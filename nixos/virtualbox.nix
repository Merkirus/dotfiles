{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
    #guest = {
    #  enable = true;
    #  x11 = true;
    #};
  };
  users.extraGroups.vboxusers.members = [ "frafau" ];
}
