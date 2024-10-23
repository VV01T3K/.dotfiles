{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    alejandra
    nixd
  ];

  nix.nixPath = ["nixpkgs=${pkgs-stable}"];
}
