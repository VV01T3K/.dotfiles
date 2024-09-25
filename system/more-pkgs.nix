{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btop # top
    entr # auto run
    atuin # history
    thefuck # da fuck
  ];
}