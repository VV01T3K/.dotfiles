{
    description = "My first flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        plasma-manager = {
            url = "github:nix-community/plasma-manager";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
        };
        nix-flatpak.url = "github:gmodena/nix-flatpak";
    };

    outputs = { self, nixpkgs, nix-flatpak, home-manager, plasma-manager, ... }:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in  {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                inherit system;
                modules = [
                    nix-flatpak.nixosModules.nix-flatpak

                    ./system/configuration.nix
                ];
            };
        };
        homeConfigurations = {
            wojtek = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ 
                    plasma-manager.homeManagerModules.plasma-manager

                    ./home/home.nix
                ];
            };
        };
    };

}
