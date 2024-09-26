{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];
  documentation = {
    dev.enable = true;
    nixos.includeAllModules = true;                                         
  };
  documentation.man = {
    generateCaches = true;
    man-db.enable = true;
    # man-db.enable = false;
    # mandoc.enable = true;
  };
}