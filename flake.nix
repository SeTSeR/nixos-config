{
  description = "A NixOS configuration flake";

  inputs = {
    nixpkgs-main-pc.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-orangepi3.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-visionfive2.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  
  outputs = { self, nixpkgs-main-pc, nixpkgs-orangepi3, nixpkgs-visionfive2, ... } @ inputs: {
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

      visionfive2 = nixpkgs-visionfive2.lib.nixosSystem {
        system = "riscv64-linux";
        modules = [
          ./visionfive2/configuration.nix
          inputs.nixos-hardware.nixosModules.starfive-visionfive-2
        ];
        specialArgs = { inherit self; nixpkgs = nixpkgs-visionfive2; };
      };
    };
    devShells.aarch64-linux.default =
      with import nixpkgs-orangepi3 { system = "aarch64-linux"; };
      mkShell {
      buildInputs = [
        nixfmt
      ];
    };
    packages.riscv64-linux = import nixpkgs-visionfive2 {
        system = "riscv64-linux";
        overlays = [ (import ./visionfive2/overlay.nix) ];
      };
  };
}
