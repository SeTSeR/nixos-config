{
  description = "My NixOS config";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    nixpkgs-stable = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-20.09";
    };
    nur = {
      type = "github";
      owner = "nix-community";
      repo = "NUR";
    };
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      type = "github";
      owner = "nix-community";
      repo = "emacs-overlay";
      rev = "64053ca574c1b6da4d209557048b5e6562201c95";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = with nixpkgs.lib;
      let
        hosts = map (fname: builtins.head (builtins.match "(.*)\\.nix" fname))
          (builtins.attrNames (builtins.readDir ./machines));
        mkHost = name:
          nixosSystem {
            system = "x86_64-linux";
            modules = [ (import ./default.nix) ];
            specialArgs = { inherit inputs name; };
          };
      in genAttrs hosts mkHost;
  };
}
