self: old:
let
  imports = import ../nix/sources.nix;
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

  # https://github.com/wiedzmin/nixos-config/blob/999e2c67e5d203771467c6c5ff2436b49aec6385/nix/firefox-addons/default.nix
  buildFirefoxXpiAddonFromArchPkg = { pname, version, addonId, url, sha256, meta, ... }:
  { stdenv, fetchurl }:
    stdenv.mkDerivation {
      name = "${pname}-${version}";

      inherit meta;

      src = fetchurl { inherit url sha256; };

      sourceRoot = ".";

      preferLocalBuild = true;
      allowSubstitutes = false;

      installPhase = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$sourceRoot/usr/lib/firefox/browser/extensions/${addonId}.xpi" "$dst/${addonId}.xpi"
      '';
    };

  bitwardenPkg = buildFirefoxXpiAddon {
    pname = "bitwarden";
    version = "1.4.1.0";
    addonId = "hello@bitwarden.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/3369227/bitwarden_free_password_manager-1.41.0-an+fx.xpi?src=";
    sha256 = "0j0rm0vzpy6vqzqqw57w7pm55lcgcxvzl9djalavjxmjqq34i05z";
    meta = with self.stdenv.lib; {
      homepage = "bitwarden.com";
      description = "A secure and free password manager for all of your devices.";
      platforms = platforms.all;
    };
  };

  tridactylPkg = buildFirefoxXpiAddonFromArchPkg rec {
    pname = "tridactyl";
    version = "1.17.1-1";
    addonId = "tridactyl.vim@cmcaine.co.uk";
    url = "https://archive.archlinux.org/packages/f/firefox-tridactyl/firefox-tridactyl-${version}-any.pkg.tar.xz";
    sha256 = "174jkqq1pmma70is1b6xksc267wjqaf9xlijgg8mrqjj8bb4b6z0";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/tridactyl/tridactyl";
      description = "Vim, but in your browser. Replace Firefox's control mechanism with one modelled on Vim.";
      license = licenses.asl20;
      platforms = platforms.all;
    };
  };

  tstPkg = buildFirefoxXpiAddon {
    pname = "treestyletab";
    version = "3.2.5";
    addonId = "treestyletab@piro.sakura.ne.jp";
    url = "https://addons.mozilla.org/firefox/downloads/file/3446051/tree_style_tab-3.2.5-fx.xpi?src=";
    sha256 = "0xsjxsfnwfq4m3xbq7vp94qnp85sq0ibm066z7w0klrnkvjjgrxs";
    meta = with self.stdenv.lib; {
      homepage = "https://piro.sakura.ne.jp/xul/_treestyletab.html.en";
      description = "Show tabs like a tree.";
      license = licenses.gpl2;
      platforms = platforms.all;
    };
  };

  ublockPkg = buildFirefoxXpiAddon {
    pname = "ublock-origin";
    version = "1.24.2";
    addonId = "uBlock0@raymondhill.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/3452970/ublock_origin-1.24.2-an+fx.xpi?src=";
    sha256 = "0kjjwi91ri958gsj4l2j3xqwj4jgkcj4mlqahqd1rz9z886sd9dy";
    meta = with self.stdenv.lib; {
      homepage = "https://github.com/gorhill/uBlock#ublock-origin";
      description = "Finally, an efficient blocker. Easy on CPU and memory.";
      license = licenses.gpl3;
      platforms = platforms.all;
    };
  };

  uMatrixPkg = buildFirefoxXpiAddon {
    pname = "umatrix";
    version = "1.4.0";
    addonId = "uMatrix@raymondhill.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/3396815/umatrix-1.4.0-an+fx.xpi?src=search";
    sha256 = "1ixz5j432rhwiqs91i3qh30s3ss30zv0l08apjibhwj1qsjhy7wr";
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

  bitwarden = self.callPackage bitwardenPkg {};
  treestyletab = self.callPackage tstPkg {};
  tridactyl = self.callPackage tridactylPkg {};
  ublock = self.callPackage ublockPkg {};
  umatrix = self.callPackage uMatrixPkg {};
  inherit (import imports.niv {}) niv;
  stable = import imports.nixpkgs-stable { config.allowUnfree = true; };
}
