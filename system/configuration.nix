# https://noogle.dev/ - website with nixos functions search
{ pkgs, ... }:

{
  imports = [
    ./nix-lsp.nix
    # ./flatpak.nix
    ./virtualisation.nix
    # ./documentation.nix
  ];
  # services.flatpak.enable = true;
  # # Shells
  environment.shells = with pkgs; [
    bash
    zsh
    fish
    # nushell
  ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  users.users.wojtek = {
    isNormalUser = true;
    description = "Wojtek";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  environment.systemPackages = [
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Elarun/contents/images/2560x1600.png
    '')
    # pkgs.flatpak
    # pkgs.gnome-software
    # pkgs.libsForQt5.discover
  ];

  networking.firewall.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 25565 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # services.xserver.dpi = 220; # default 96
  # services.xserver.upscaleDefaultCursor = true; # default false
  # environment.variables = {
  #   GDK_SCALE = "2.2"; # default 1 I think
  #   GDK_DPI_SCALE = "0.4"; # default 1 I think
  #   _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2.2"; # default 1 I think
  #   QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  #   XCURSOR_SIZE = "64"; # default 16 I think
  # };
}
