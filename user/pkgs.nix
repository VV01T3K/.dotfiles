{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #vesktop
    onlyoffice-bin
    whatsapp-for-linux
    warp-terminal
    tmux # windowing
    kitty # terminal
    trash-cli # trash
    #yazi # cli file manager
    legcord
  ];
}
