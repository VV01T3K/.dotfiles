{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #vesktop
    onlyoffice-bin
    spotify
    whatsapp-for-linux
    warp-terminal
    tmux # windowing
    kitty # terminal
    trash-cli # trash
    yazi # cli file manager
  ];
}
