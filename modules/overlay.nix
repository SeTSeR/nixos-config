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
      rev = "v0.1.4";
      sha256 = "1b6bph086qlaz5l0zslakniyzx4cwg1532vmza2fci4x64l54mkw";
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
    version = "4.28.0.4";
    addonId = "support@lastpass.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/2958892/lastpass_password_manager-4.28.0.4-fx.xpi?src=";
    sha256 = "dde8c89bdc0daedcdeedcbab1af99d464d56b4a6699355e57b59b5b0f0473f33";
    meta = with self.stdenv.lib; {
      homepage = "lastpass.com";
      description = "LastPass, an award-winning password manager, saves your passwords and gives you secure access from every computer and mobile device.";
      platforms = platforms.all;
    };
  };

  tstPkg = buildFirefoxXpiAddon {
    pname = "treestyletab";
    version = "3.0.15";
    addonId = "treestyletab@piro.sakura.ne.jp";
    url = "https://addons.mozilla.org/firefox/downloads/file/2993967/tree_style_tab-3.0.15-fx.xpi?src=";
    sha256 = "99f851e16457a19d8c7c6f9c1911388c03bcb6fd5c8ea939912be3a009a751b9";
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

  tdesktop = old.tdesktop.overrideAttrs (oldAttrs: {
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
  ublock = self.callPackage ublockPkg {};
  umatrix = self.callPackage uMatrixPkg {};
}
