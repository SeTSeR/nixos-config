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
    emacs-overlay = {
      type = "github";
      owner = "nix-community";
      repo = "emacs-overlay";
    };
    emacs-overlay-pinned = {
      type = "github";
      owner = "nix-community";
      repo = "emacs-overlay";
      rev = "60ccd988e041b4dbb3e4f03a00e80173c6a57982";
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
