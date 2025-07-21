{
  description = "A NixOS configuration flake";

  inputs.nixpkgs-orangepi3.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs-orangepi3 }: {
    nixosConfigurations = {
      orangepi3 = nixpkgs-orangepi3.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./orangepi3/configuration.nix
        ];
        specialArgs = { inherit self; nixpkgs = nixpkgs-orangepi3; };
      };
    };
  };
}
