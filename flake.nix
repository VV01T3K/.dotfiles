{
  description = "My first advanced flake";

  outputs =
    { self, ... }@inputs:
    let
      lib = inputs.nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      # pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};

      systemSettings = {
        system = system;
        hostname = "nixos";
      };

      userSettings = {
        # computer
        username = "wojtek";
        dotfilesDir = "/home/wojtek/.dotfiles";

        # github
        nameGithub = "VV01T3K";
        emailGithub = "wojteks.access@gmail.com";
      };

    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix
            ./system/hardware-configuration.nix
            ./system/common.nix
            ./system/pkgs.nix
            inputs.nix-flatpak.nixosModules.nix-flatpak
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
            # inherit pkgs-stable;
          };
        };
      };
      homeConfigurations = {
        wojtek = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            inputs.plasma-manager.homeManagerModules.plasma-manager
            ./user/home.nix
            ./user/pkgs.nix
          ];
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
            # inherit pkgs-stable;
          };
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

}
