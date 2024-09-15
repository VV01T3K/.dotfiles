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
      df = "dust";
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
      cd ~/.dotfiles/
      sudo nixos-rebuild switch --flake .
      home-manager switch --flake .
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
  };

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
    bashrcExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ]; then
        # Check for a currently running instance of the agent
        RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
        if [ "$RUNNING_AGENT" = "0" ]; then
              # Launch a new instance of the agent
              ssh-agent -s &> $HOME/.ssh/ssh-agent
        fi
        eval `cat $HOME/.ssh/ssh-agent` > /dev/null
        ssh-add $HOME/.ssh/id_ed25519.pub 2> /dev/null
      fi
    '';
  };
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
  programs.zoxide.enable = true;

  #!! git signing with ssh key
  # https://jeppesen.io/git-commit-sign-nix-home-manager-ssh/
  # ====Uncomment to repair signing commits with ssh key====
  # home.file.".ssh/allowed_signers".text =
  #   "* ${builtins.readFile /home/wojtek/.ssh/id_ed25519.pub}";
  # ========================================================
  programs.git = {
    enable = true;
    userName  = "VV01T3K";
    userEmail = "wojteks.access@gmail.com";
    # extraConfig = {
    #   # init.defaultBranch = "main";

    #   # Sign all commits using ssh key
    #   # commit.gpgsign = true;
    #   # gpg.format = "ssh";
    #   # gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    #   # user.signingkey = "~/.ssh/id_ed25519.pub";
    # };
  };

  #!! fix for vscode clone to container (ssh forwarding)
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
  };

  # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
