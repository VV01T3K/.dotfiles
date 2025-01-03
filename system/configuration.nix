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
}
