{
  description = "My NixOS config";

  inputs = { nixpkgs = {
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
      ref = "bqv-flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay-pinned = {
      type = "github";
      owner = "nix-community";
      repo = "emacs-overlay";
      rev = "6adc035f5e8b600af4269ae4ee95824e802f50a9";
      flake = false;
    };
    emacs-overlay = {
      type = "github";
      owner = "nix-community";
      repo = "emacs-overlay";
    };
  };

  outputs = { nixpkgs, nix, self, ... }@inputs: {
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
    legacyPackages.x86_64-linux =
      (builtins.head (builtins.attrValues self.nixosConfigurations)).pkgs;
  };
}
