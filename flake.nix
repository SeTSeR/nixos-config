{
  description = "My NixOS config";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs-channels";
      ref = "nixos-unstable";
    };
    nixpkgs-stable = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs-channels";
      ref = "nixos-20.03";
    };
    NUR = {
      type = "github";
      owner = "nix-community";
      repo = "NUR";
    };
    home-manager = {
      type = "github";
      owner = "rycee";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      type = "github";
      owner = "nix-community";
      repo = "emacs-overlay";
      rev = "7d53baa6d8bb989bb37ee7120457eac8695dfcd8";
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
