# { ... }:

# {
#   services.flatpak.enable = true;
#   # services.flatpak.uninstallUnmanaged = true;
#   services.flatpak.uninstallUnmanaged = false;

#   # services.flatpak.update.auto = {
#   #   enable = true;
#   #   onCalendar = "weekly"; # Default value
#   # };
#   # also possible to use flathub-beta
#   # services.flatpak.remotes = lib.mkOptionDefault [{
#   #   name = "flathub-beta";
#   #   location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
#   # }];

#   # flatpak search bottles --> com.usebottles.bottles
#   services.flatpak.packages = [
#     "com.obsproject.Studio"
#     # "io.podman_desktop.PodmanDesktop"
#     # "com.spotify.Client"
#     # "com.usebottles.bottles"
#     # "com.obsproject.Studio"
#     # "io.github.zen_browser.zen"
#   ];
# }
