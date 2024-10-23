{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    alejandra
    nixd
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
