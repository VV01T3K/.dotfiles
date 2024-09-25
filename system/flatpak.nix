{ config, pkgs, ... }:

{
  services.flatpak.enable = true;
    services.flatpak.uninstallUnmanaged = true;
    services.flatpak.update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };
    # also possible to use flathub-beta
    # services.flatpak.remotes = lib.mkOptionDefault [{
    #   name = "flathub-beta";
    #   location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    # }];
    # flatpak search bottles --> com.usebottles.bottles
    services.flatpak.packages = [
      "io.podman_desktop.PodmanDesktop"
      # "com.usebottles.bottles"
  ];
}