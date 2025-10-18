{
  description = "A NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        main-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./main-pc/configuration.nix
          ];
          specialArgs = {
            inherit self nixpkgs;
          };
        };

        orangepi3 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./orangepi3/configuration.nix
          ];
          specialArgs = {
            inherit self nixpkgs;
          };
        };

        visionfive2 = nixpkgs.lib.nixosSystem {
          system = "riscv64-linux";
          modules = [
            ./visionfive2/configuration.nix
            inputs.nixos-hardware.nixosModules.starfive-visionfive-2
          ];
          specialArgs = {
            inherit self nixpkgs;
          };
        };
      };
      formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixfmt-tree;
      packages.riscv64-linux = import nixpkgs {
        system = "riscv64-linux";
        overlays = [ (import ./visionfive2/overlay.nix) ];
      };
    };
}
