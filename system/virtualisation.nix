{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker-compose # start group of containers for dev
    docker # containerization
    # bottles
    podman-desktop
    # wineWowPackages.waylandFull
  ];

  # https://nixos.wiki/wiki/WayDroid
  # virtualisation.waydroid.enable = true;

  # Kontenaryzacja
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

}
