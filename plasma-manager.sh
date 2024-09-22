nix-channel --add https://github.com/nix-community/plasma-manager/archive/trunk.tar.gz plasma-manager
nix-channel --update plasma-manager

https://github.com/nix-community/plasma-manager/blob/trunk/examples/homeManagerFlake/flake.nix

{ pkgs, ...}:
{
  imports = [
    <plasma-manager/modules>
  ];

  programs = {
    plasma = {
      enable = true;
      # etc.
    };
  };
}

