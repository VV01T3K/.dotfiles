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
      f = "fuck";
      z- = "z -";
      cd- = "z -";
    };
in
{
  home.packages = with pkgs; [
    (writeShellScriptBin "rebuild" ''
      nh os switch
      nh home switch
    '')
    (writeShellScriptBin "update" ''
      nh os switch --update
      nh home switch --update
      flatpak update -y
    '')
    (writeShellScriptBin "home" ''
      nh home switch
    '')
    (writeShellScriptBin "os" ''
      nh os switch
    '')
    (writeShellScriptBin "clean" ''
      nh clean all
      echo "System garbage collection done."
      echo "Optimising"
      nix-store --optimise
      nh clean all
      echo "Store optimisation done."
      os
      du -sh /nix/store
      df -h
    '')
  ];

    programs.bash = {
        enable = true;
        shellAliases = myAliases;
        # bashrcExtra = ''
        #   # Add your own customizations to the shell environment here.
        # '';
        initExtra = ''
        export MANPAGER='sh -c "col -bx | bat -l man -p"'
        export MANROFFOPT="-c";
        ''; 
    };

    programs.direnv = { # maybe also lorri
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
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

    # maybe i should use zplug instead or smth similar

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
        "colored-man-pages" # the colored
      ];
    };

    plugins = [
      # nix-prefetch-url https://github.com/zsh-users/zsh-history-substring-search/archive/v1.1.0.tar.gz --unpack

      # {
      #   name = "zsh-history-substring-search";
      #   file = "zsh-history-substring-search.plugin.zsh";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "zsh-users";
      #     repo = "zsh-history-substring-search";
      #     rev = "v1.1.0";
      #     sha256 = "0vjw4s0h4sams1a1jg9jx92d6hd2swq4z908nbmmm2qnz212y88r";
      #   };
      # }
      {
        name = "you-should-use";
        file = "you-should-use.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.9.0";
          sha256 = "1kb11rqhmsnv3939prb9f00c1giqy3200sjnhh7cxcfjcncq0y7v";
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
}