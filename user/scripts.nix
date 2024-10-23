{ config, pkgs, ... }:

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
      sudo nix-collect-garbage
      sudo nix-collect-garbage -d
      echo "System garbage collection done."
      echo "Optimising"
      nix-store --optimise
      echo "Store optimisation done."
      sudo nixos-rebuild boot --flake $FLAKE
      du -sh /nix/store
      # df -h
    '')
    (writeShellScriptBin "clean-deep" ''
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
}
