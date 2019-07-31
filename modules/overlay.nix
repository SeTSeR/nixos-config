self: old:
let
  cacosPkg = { gcc8Stdenv, fetchgit, pkgconfig, boost, cmake, curl, gcc8, git }:
  let
    boostpkg = boost.override { enableStatic = true; };
    stdenv = gcc8Stdenv;
  in stdenv.mkDerivation rec {
    name = "cacos";

    src = fetchgit {
      url = "https://github.com/BigRedEye/cacos";
      rev = "v1.0.0";
      sha256 = "0av84475dxamvmf8slqp2h6p2y4j08nm94qjc6rvxcqbp54bn1zi";
      fetchSubmodules = true;
    };

    nativeBuildInputs = [ cmake pkgconfig ];
    buildInputs = [ boostpkg curl gcc8 git ];

    cmakeFlags = [ "-DCMAKE_USE_CONAN=OFF -DCMAKE_BUILD_TYPE=Release" ];

    enableParallelBuilding = true;

    meta = {
      homepage = "https://github.com/BigRedEye/cacos";
      description = "Ejudge client and local testing system";
      license = stdenv.lib.licenses.mit;
    };
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

  lastpassPkg = buildFirefoxXpiAddon {
    pname = "lastpass";
    version = "4.29.0.4";
    addonId = "support@lastpass.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/3019318/lastpass_password_manager-4.29.0.4-fx.xpi?src=";
    sha256 = "a31f86b22a13fa1c363428d207a68ac5fde664dde5e8557ff598ff39c77825be";
    meta = with self.stdenv.lib; {
      homepage = "lastpass.com";
      description = "LastPass, an award-winning password manager, saves your passwords and gives you secure access from every computer and mobile device.";
      platforms = platforms.all;
    };
  };

  tridactylPkg = buildFirefoxXpiAddon {
    pname = "tridactyl";
    version = "1.16.2";
    addonId = "tridactyl.vim@cmcaine.co.uk";
    url = "https://addons.mozilla.org/firefox/downloads/file/3348489/tridactyl-1.16.2-an+fx.xpi?src=";
    sha256 = "5aadd08d0c557ae38d37a82534110585fa81e20c5068cfd09cd49be008cd6365";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/tridactyl/tridactyl";
      description = "Vim, but in your browser. Replace Firefox's control mechanism with one modelled on Vim.";
      license = licenses.apache2;
      platforms = platforms.all;
    };
  };

  tstPkg = buildFirefoxXpiAddon {
    pname = "treestyletab";
    version = "3.1.5";
    addonId = "treestyletab@piro.sakura.ne.jp";
    url = "https://addons.mozilla.org/firefox/downloads/file/3339183/tree_style_tab-3.1.5-fx.xpi?src=";
    sha256 = "772f169dc0424e55c63db2d1d5635c47c7cbdd18dbc6c077d2bfea9799e147f5";
    meta = with self.stdenv.lib; {
      homepage = "https://piro.sakura.ne.jp/xul/_treestyletab.html.en";
      description = "Show tabs like a tree.";
      license = licenses.gpl2;
      platforms = platforms.all;
    };
  };

  ublockPkg = buildFirefoxXpiAddon {
    pname = "ublock-origin";
    version = "1.19.6";
    addonId = "uBlock0@raymondhill.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/2990453/ublock_origin-1.19.6-an+fx.xpi?src=";
    sha256 = "42cc200785c6c644a557a8439e4c94e835e83ff7a7dcbf0d2b2d7a7e8a0efa88";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/gorhill/uBlock#ublock-origin";
      description = "Finally, an efficient blocker. Easy on CPU and memory.";
      license = licenses.gpl3;
      platforms = platforms.all;
    };
  };

  uMatrixPkg = buildFirefoxXpiAddon {
    pname = "umatrix";
    version = "1.3.16";
    addonId = "uMatrix@raymondhill.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/1193322/umatrix-1.3.16-an+fx.xpi?src=";
    sha256 = "03dcdbca2135f81820167c49ac83b9fc75f1ba3c1792a1713f886d9274ad7fb6";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/gorhill/uMatrix";
      description = "Point & click to forbid/allow any class of requests made by your browser. Use it to block scripts, iframes, ads, facebook, etc.";
      license = licenses.gpl3;
      platforms = platforms.all;
    };
  };
in {
  cacos = self.pkgs.callPackage cacosPkg { };

  tdesktopWideBaloons = old.tdesktop.overrideAttrs (oldAttrs: {
    patches = [
      "${
        builtins.fetchGit {
          url = "https://github.com/msva/mva-overlay";
          rev = "e5121619c9814b36284146dbe3dae92cf41a7c25";
        }
      }/net-im/telegram-desktop/files/patches/9999/conditional/wide-baloons/0001_baloons-follows-text-width-on-adaptive-layout.patch"
    ] ++ oldAttrs.patches;
  });

  nixfmt = (self.callPackage (builtins.fetchGit {
    url = "https://github.com/serokell/nixfmt";
    rev = "1b9b16dbefba39514d01f00836ce3b69788257b0";
  }) { installOnly = true; });

  lastpass = self.callPackage lastpassPkg {};
  treestyletab = self.callPackage tstPkg {};
  tridactyl = self.callPackage tridactylPkg {};
  ublock = self.callPackage ublockPkg {};
  umatrix = self.callPackage uMatrixPkg {};
}
