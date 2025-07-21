{
  description = "A NixOS configuration flake";

  inputs.nixpkgs-main-pc.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.nixpkgs-orangepi3.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs-main-pc, nixpkgs-orangepi3 }: {
    nixosConfigurations = {
      main-pc = nixpkgs-main-pc.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./main-pc/configuration.nix
        ];
        specialArgs = { inherit self; nixpkgs = nixpkgs-main-pc; };
      };
      
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
