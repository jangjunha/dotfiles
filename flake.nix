{
  description = "Darwin configuration of junha";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      darwinConfigurations = {
        "junha-air2022" = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit self; };
          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            ./configuration.nix
          ];
        };
      };
    };
}
