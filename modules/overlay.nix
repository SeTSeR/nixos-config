{inputs, config}:
self: old:
let
  dot2texPkg = { stdenv, buildPythonPackage, fetchgit, isPy3k, pyparsing }:
  buildPythonPackage rec {
    pname = "dot2tex";
    version = "2.11.3";

    src = fetchgit {
      url = "https://github.com/SeTSeR/dot2tex";
      rev = "4b25559cd9b958b2f372baac3d4f647b590e4356";
      sha256 = "098gx2dr9v00y7ckn5183gczijzagzdb20z2v0svlrnzshfdirn1";
    };

    disabled = isPy3k;

    propagatedBuildInputs = [ pyparsing ];
  };

  # https://gitlab.com/rycee/nur-expressions/blob/master/pkgs/firefox-addons/default.nix
  buildFirefoxXpiAddon =
  { pname, version, addonId, url, sha256, meta, ... }:
  { stdenv, fetchurl }:
      stdenv.mkDerivation {
        name = "${pname}-${version}";

        inherit meta;

        src = fetchurl {
          inherit url sha256;
        };

        preferLocalBuild = true;
        allowSubstitutes = false;

        buildCommand = ''
          dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
          mkdir -p "$dst"
          install -v -m644 "$src" "$dst/${addonId}.xpi"
        '';
  };

  tridactylPkg = buildFirefoxXpiAddon {
    pname = "tridactyl";
    version = "1.18.1";
    addonId = "tridactyl.vim@cmcaine.co.uk";
    url = "https://addons.mozilla.org/firefox/downloads/file/3557449/tridactyl-1.18.1-an+fx.xpi?src=";
    sha256 = "1hvhkk6gnc39v9fpcx96xkhpkf107gcgqcx2p8222x7s6zjzgrw2";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/tridactyl/tridactyl";
      description = "Vim, but in your browser. Replace Firefox's control mechanism with one modelled on Vim.";
      license = licenses.asl20;
      platforms = platforms.all;
    };
  };

  tstPkg = buildFirefoxXpiAddon {
    pname = "treestyletab";
    version = "3.3.6";
    addonId = "treestyletab@piro.sakura.ne.jp";
    url = "https://addons.mozilla.org/firefox/downloads/file/3511277/tree_style_tab_-3.3.6-fx.xpi?src=";
    sha256 = "09849frhc12w94ig7m405lrgcmr434a6204dazg4nmrmh8rckizr";
    meta = with self.stdenv.lib; {
      homepage = "https://piro.sakura.ne.jp/xul/_treestyletab.html.en";
      description = "Show tabs like a tree.";
      license = licenses.gpl2;
      platforms = platforms.all;
    };
  };
in {
  dot2tex = self.callPackage dot2texPkg {
    buildPythonPackage = self.pythonPackages.buildPythonPackage;
    isPy3k = self.pythonPackages.isPy3k;
    pyparsing = self.pythonPackages.pyparsing;
  };

  treestyletab = self.callPackage tstPkg {};
  tridactyl = self.callPackage tridactylPkg {};
  stable = import inputs.stable ({
    config = config.nixpkgs.config;
    localSystem = { system = "x86_64-linux"; };
  });
  nur = (import inputs.NUR {
    pkgs = self;
    nurpkgs = self;
  }).repos;
}
