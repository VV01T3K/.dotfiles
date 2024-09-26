{
    description = "My first advanced flake";

    outputs = inputs@{ self, nixpkgs, nix-flatpak, home-manager, plasma-manager, ... }:
    let
        lib = inputs.nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = inputs.nixpkgs.legacyPackages.${system};

        systemSettings = {
            system = system;
            hostname = "nixos";
        };

        userSettings = {
            # computer
            username = "wojtek";
            dotfilesDir = "/home/wojtek/.dotfiles";

            # github
            nameGithub  = "VV01T3K";
            emailGithub = "wojteks.access@gmail.com";
        };

    in  {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                inherit system;
                modules = [
                    nix-flatpak.nixosModules.nix-flatpak
                    ./system/configuration.nix
                ];
                specialArgs = {
                    inherit systemSettings;
                    inherit userSettings;
                };
            };
        };
        homeConfigurations = {
            wojtek = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ 
                    plasma-manager.homeManagerModules.plasma-manager
                    ./user/home.nix
                ];
                extraSpecialArgs = {
                    inherit systemSettings;
                    inherit userSettings;
                };
            };
        };
    };

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

}
