{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    docker-compose # start group of containers for dev
  ];

  # Kontenaryzacja
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.waydroid.enable = true;

}