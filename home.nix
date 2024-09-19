{ config, pkgs, ... }:
let 
  myAliases = {
      neofetch = "fastfetch";
      ls = "eza --icons=auto";
      ll = "ls --long";
      tree = "ls --tree";
      # grep = "ripgrep"; # rg is shortcut for ripgrep
      gzip = "pigz";
      # cat = "bat";
      cd = "z";
      cdi = "zi";
      # df = "dust";
      cl = "clear";
      ".." = "cd ..";
    };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wojtek";
  home.homeDirectory = "/home/wojtek";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "rebuild" ''
      nh os switch
      nh home switch
    '')
    (pkgs.writeShellScriptBin "update" ''
      nh os switch --update
      nh home switch --update
    '')
    (pkgs.writeShellScriptBin "home" ''
      nh home switch
    '')
    (pkgs.writeShellScriptBin "os" ''
      nh os switch
    '')
    (pkgs.writeShellScriptBin "clean" ''
      nh clean all
      nix-store --optimise
      echo "System garbage collection done."
    '')

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wojtek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    # EZA_ICON_SPACING = "10";
    # EZA_ICONS_AUTO
    # NIX_BUILD_SHELL = "zsh";
    DIRENV_LOG_FORMAT = "";
    # or export DIRENV_LOG_FORMAT=$'\033[2mdirenv: %s\033[0m'
    YSU_MESSAGE_POSITION="after";
    YSU_MODE="ALL";
    # FLAKE = "/home/wojtek/.dotfiles";
  };

  programs.direnv = { # maybe also lorri
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
    # bashrcExtra = ''
    #   # Add your own customizations to the shell environment here.
    # '';
  };

  programs.zoxide.enable = true;
  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # maybe i should use zplug instead

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "sudo" # the sudo plugin provides many aliases and a few useful functions.
        "git" # the git plugin provides many aliases and a few useful functions.
        "history" # the history plugin provides many aliases and a few useful functions.
        "docker" # the docker plugin provides many aliases and a few useful functions.
        # "golang" # the golang plugin provides many aliases and a few useful functions.
        # "starship" # the starship plugin provides many aliases and a few useful functions.
        "common-aliases" # This plugin creates helpful shortcut aliases for many commonly used commands.
        "aliases" # als # the aliases plugin provides many aliases and a few useful functions.
        #for direnv https://shivamarora.medium.com/a-guide-to-manage-your-environment-variables-in-a-better-way-using-direnv-2c1cd475c8e
        "direnv" # the direnv plugin provides many aliases and a few useful functions. (direnv allow) to load/unload environment variables
      ];
    };

    plugins = [
      # {
      #   name = "zsh-history-substring-search";
      #   file = "zsh-history-substring-search.plugin.zsh";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "zsh-users";
      #     repo = "zsh-history-substring-search";
      #     rev = "v1.1.0";
      #     sha256 = "sha256-GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4=";
      #   };
      # }
      {
        name = "you-should-use";
        file = "you-should-use.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.9.0";
          sha256 = "sha256-+3iAmWXSsc4OhFZqAMTwOL7AAHBp5ZtGGtvqCnEOYc0=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

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
