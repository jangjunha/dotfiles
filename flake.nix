{
  description = "Darwin configuration of junha";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
        "junha-momo-m5" = nix-darwin.lib.darwinSystem {
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
