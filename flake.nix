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
    };
  };

  outputs = { nixpkgs, ... }@inputs: rec {
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
    legacyPackages = nixpkgs.legacyPackages;
    emacsConfig = let readWithSubstitute = file:
      builtins.readFile (nixpkgs.substituteAll ({ 
        config = nixosConfigurations.config;
        lib = nixpkgs.lib;
        pkgs = nixpkgs; } //
      { src = file; }));
      modulePaths = dir: map (fname: dir + "/${fname}") (builtins.attrNames (builtins.readDir dir));
                  in nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
                    src = ./modules/users/smakarov/emacs;
                    unpackPhase = true;
                    buildPhase = true;
                    installPhase = ''
install -t $out $src/early-init.el $src/init.el $src/pkgs $src/yasnippet-snippets
                    '';
                  };
  };
}
