{ nixpkgs ? (import <nixpkgs> {}), compiler ? "ghc865" }:
let installer =
  { mkDerivation, stack, base, directory, filepath, process, stdenv, unix }:
mkDerivation rec {
  pname = "installer";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base directory filepath process unix
  ];
  license = stdenv.lib.licenses.bsd3;
};
    drv = nixpkgs.pkgs.haskell.packages.${compiler}.callPackage installer {};
in if nixpkgs.lib.inNixShell then drv.env else drv
