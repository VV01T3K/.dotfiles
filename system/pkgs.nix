{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # btop # top
    entr # auto run
    atuin # history
    thefuck # da fuck
    # discord
  ];

  fonts.packages = with pkgs; [
    # Nerd Fonts
    nerd-fonts.fira-code
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.geist-mono
    nerd-fonts.jetbrains-mono
    jetbrains-mono
  ];
}
