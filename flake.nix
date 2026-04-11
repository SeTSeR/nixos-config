{
  description = "A NixOS configuration flake";

  inputs = {
    ewm = {
      url = "https://codeberg.org/ezemtsov/ewm/archive/master.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      ewm,
      nixpkgs,
      nixpkgs-stable,
      nix-on-droid,
      sops-nix,
    }:
    {
      nixosConfigurations = {
        main-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./main-pc/configuration.nix
            ewm.nixosModules.default
            sops-nix.nixosModules.sops
          ];
          specialArgs = {
            inherit self nixpkgs;
          };
        };

        orangepi3 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./orangepi3/configuration.nix
            sops-nix.nixosModules.sops
          ];
          specialArgs = {
            inherit self nixpkgs;
          };
        };
      };

      formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixfmt-tree;

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs-stable { system = "aarch64-linux"; };
        modules = [ ./galaxy-s22/configuration.nix ];
        extraSpecialArgs = {
          nixpkgs = nixpkgs-stable;
          pkgsUnstable = import nixpkgs { system = "aarch64-linux"; };
        };
      };
    };
}
