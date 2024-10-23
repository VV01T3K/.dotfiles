{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt-rfc-style
    # alejandra
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
