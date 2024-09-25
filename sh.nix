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
}