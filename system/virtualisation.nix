{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker-compose # start group of containers for dev
    docker # containerization
    bottles
    # wineWowPackages.waylandFull
  ];
  virtualisation.waydroid.enable = true;

  # Kontenaryzacja
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

}