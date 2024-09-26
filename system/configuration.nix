# https://noogle.dev/ - website with nixos functions search
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./flatpak.nix
      ./virtualisation.nix
    ];

  # # Shells
  environment.shells = with pkgs; [ bash zsh fish nushell ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  users.users.wojtek = {
    isNormalUser = true;
    description = "Wojtek";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # documentation = {
  #   dev.enable = true;
  #   nixos.includeAllModules = true;                                         
  # };
  # documentation.man = {
  #   generateCaches = true;
  #   man-db.enable = true;
  # };

  environment.systemPackages = with pkgs; [
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Elarun/contents/images/2560x1600.png
    '')
  ];

  networking.firewall.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 25565 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
