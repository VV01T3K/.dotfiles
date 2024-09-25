{ config, pkgs, ... }:

{
  imports = [
    ./sh.nix
    ./plasma.nix
    ./more-pkgs.nix
  ];
  home.username = "wojtek";
  home.homeDirectory = "/home/wojtek";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "Hack" "GeistMono" "JetBrainsMono" ]; })
      kdePackages.kate
      thunderbird
      brave
      vscode
      discord
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
    # EZA_ICON_SPACING = "10";
    # EZA_ICONS_AUTO
    # NIX_BUILD_SHELL = "zsh";
    DIRENV_LOG_FORMAT = "";
    YSU_MESSAGE_POSITION="after";
    YSU_MODE="ALL";
    FLAKE = "/home/wojtek/.dotfiles";
    NIXOS_OZONE_WL = "1";
  };

  programs.git = {
    enable = true;
    userName  = "VV01T3K";
    userEmail = "wojteks.access@gmail.com";
    # extraConfig = {
    #   # init.defaultBranch = "main";
    # };
  };

  #!! fix for vscode (and etc) clone to container (ssh forwarding)
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
  };

  # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "weekly";
  };
}
