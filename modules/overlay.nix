{ inputs, config }:
self: old:
{
  dot2tex = old.dot2tex.overrideAttrs (oldAttrs: {
    src = self.fetchgit {
      url = "https://github.com/SeTSeR/dot2tex";
      rev = "4b25559cd9b958b2f372baac3d4f647b590e4356";
      sha256 = "098gx2dr9v00y7ckn5183gczijzagzdb20z2v0svlrnzshfdirn1";
    };
  });

  tdlib = old.tdlib.overrideAttrs (oldAtrs: {
    version = "1.7.7";
    src = self.fetchgit {
      url = "https://github.com/tdlib/td";
      rev = "7135caa2bef38939f58e9e206db83fd316236682";
      sha256 = "sha256-gk5xJMuhOthMLO9VjQhcCPcPCxiz27e3ec8CxHjxSCA=";
    };
  });

  emacsPackagesFor = emacs: (old.emacsPackagesFor emacs).overrideScope' (self: super: {
    telega = super.melpaPackages.telega;
    tsc = old.symlinkJoin {
      name = "tsc";
      paths = [
        super.tsc
        (old.rustPlatform.buildRustPackage rec {
          pname = "tsc-dyn";
          version = "0.15.1";
          cargoPatches = [ ./add-cargo-lock.patch ];
          src = old.fetchzip {
            name = "tsc-${version}.tar.gz";
            url = "https://github.com/ubolonton/emacs-tree-sitter/releases/download/${version}/${src.name}";
            sha256 = "sha256-7HdKbYoOhFgO6hWyM9bL25JtIwrTBnhmYebfxmnkt04=";
          };
          nativeBuildInputs = [ old.clang ];
          configurePhase = ''
            export LIBCLANG_PATH="${old.llvmPackages.libclang.lib}/lib"
          '';
          postInstall = ''
            LIB=($out/lib/libtsc_dyn.*)
            TSC_PATH=$out/share/emacs/site-lisp/elpa/tsc-${super.tsc.version}
            install -d $TSC_PATH
            install -m444 $out/lib/libtsc_dyn.* $TSC_PATH/''${LIB/*libtsc_/tsc-}
            echo -n $version > $TSC_PATH/DYN-VERSION
            rm -r $out/lib
          '';
          cargoSha256 = "sha256-AVIa0sdcx9JUDGVF6z5K+uJLG5wUwi/xPSTftnINVCk=";
        })
      ];
    };
    tree-sitter-langs = old.symlinkJoin rec {
      name = "tree-sitter-langs";
      paths =
        let
          tree-sitter-grammars = old.stdenv.mkDerivation rec {
            name = "tree-sitter-grammars";
            version = "0.10.0";
            src = old.fetchzip {
              name = "tree-sitter-grammars-linux-${version}.tar.gz";
              url = "https://github.com/ubolonton/tree-sitter-langs/releases/download/${version}/${src.name}";
              sha256 = "sha256-XUbU4Q/JAFPINIJ88LbegVFNBLEb6VZ5waxdl6Sw2Sw=";
              stripRoot = false;
            };
            installPhase = ''
              install -d $out/langs/bin
              install -m444 * $out/langs/bin
              echo -n $version > $out/langs/bin/BUNDLE-VERSION
            '';
          };
        in
          [
            (super.tree-sitter-langs.overrideAttrs (oldAttrs: {
              postPatch = oldAttrs.postPatch or "" + ''
          substituteInPlace ./tree-sitter-langs-build.el \
          --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir"  "tree-sitter-langs-grammar-dir \"${tree-sitter-grammars}/langs\""
        '';
            }))
            tree-sitter-grammars
          ];
    };
  });
  
  stable = import inputs.nixpkgs-stable ({
    config = config.nixpkgs.config;
    localSystem = { system = "x86_64-linux"; };
  });
}
