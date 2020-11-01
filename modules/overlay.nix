{ inputs, config }:
self: old:
let
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

  tstPkg = buildFirefoxXpiAddon {
    pname = "treestyletab";
    version = "3.5.34";
    addonId = "treestyletab@piro.sakura.ne.jp";
    url = "https://addons.mozilla.org/firefox/downloads/file/3664524/tree_style_tab_-3.5.34-fx.xpi";
    sha256 = "sha256-VTPOD9EGC3oonmZud6+KaqigxN8eDDzovwKX/2W/8GY=";
    meta = with self.stdenv.lib; {
      homepage = "https://piro.sakura.ne.jp/xul/_treestyletab.html.en";
      description = "Show tabs like a tree.";
      license = licenses.gpl2;
      platforms = platforms.all;
    };
  };

  direnvPkg =
    { buildVscodeMarketplaceExtension, stdenv }:
    buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "vscode-direnv";
        publisher = "Rubymaniac";
        version = "0.0.2";
        sha256 = "sha256-TVvjKdKXeExpnyUh+fDPl+eSdlQzh7lt8xSfw1YgtL4=";
      };
      meta = {
        license = stdenv.lib.licenses.mit;
      };
    };

  schemePkg =
      { buildVscodeMarketplaceExtension, stdenv }:
      buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "vscode-scheme";
          publisher = "sjhuangx";
          version = "0.4.0";
          sha256 = "sha256-BN+C64YQ2hUw5QMiKvC7PHz3II5lEVVy0Shtt6t3ch8=";
        };
        meta = {
          license = stdenv.lib.licenses.mit;
        };
      };

  rustPkg =
      { buildVscodeMarketplaceExtension, stdenv }:
      buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "rust";
          publisher = "rust-lang";
          version = "0.7.8";
          sha256 = "sha256-Y33agSNMVmaVCQdYd5mzwjiK5JTZTtzTkmSGTQrSNg0=";
        };
        meta = {
          license = stdenv.lib.licenses.mit;
        };
      };

  orgPkg =
      { buildVscodeMarketplaceExtension, stdenv }:
      buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "org-mode";
          publisher = "vscode-org-mode";
          version = "1.0.0";
          sha256 = "sha256-o9CIjMlYQQVRdtTlOp9BAVjqrfFIhhdvzlyhlcOv5rY=";
        };
        meta = {
          license = stdenv.lib.licenses.mit;
        };
      };

  emacsPkg =
      { buildVscodeMarketplaceExtension, stdenv }:
      buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "emacs-mcx";
          publisher = "tuttieee";
          version = "0.23.5";
          sha256 = "sha256-elh0NapHDUhkfAZ5xXlCI5Mi7/u9e1QjX/YZ7nvJzTo=";
        };
        meta = {
          license = stdenv.lib.licenses.mit;
        };
      };
in {
  dot2tex = old.dot2tex.overrideAttrs (oldAttrs: {
    src = self.fetchgit {
      url = "https://github.com/SeTSeR/dot2tex";
      rev = "4b25559cd9b958b2f372baac3d4f647b590e4356";
      sha256 = "098gx2dr9v00y7ckn5183gczijzagzdb20z2v0svlrnzshfdirn1";
    };    
  });

  tdlib = old.tdlib.overrideAttrs (oldAttrs: {
    version = "1.6.9";

    src = self.fetchFromGitHub {
      owner = "tdlib";
      repo = "td";
      rev = "30921606c5a5ea4c31193adcbb457cce4503751d";
      sha256 = "sha256-Lcu0zZqbO/wVS6jnRsw15rkQ/8B8StcAmOVSreN4rfQ=";
    };
  });

  treestyletab = self.callPackage tstPkg {};
  vscode-extensions = old.vscode-extensions // {
    Rubymaniac.vscode-direnv = self.callPackage direnvPkg { inherit (self.vscode-utils) buildVscodeMarketplaceExtension; };
    sjhuangx.vscode-scheme = self.callPackage schemePkg { inherit (self.vscode-utils) buildVscodeMarketplaceExtension; };
    tuttieee.emacs-mcx = self.callPackage emacsPkg { inherit (self.vscode-utils) buildVscodeMarketplaceExtension; };
    rust-lang.rust = self.callPackage rustPkg { inherit (self.vscode-utils) buildVscodeMarketplaceExtension; };
    vscode-org-mode.org-mode = self.callPackage orgPkg { inherit (self.vscode-utils) buildVscodeMarketplaceExtension; };
  };
  stable = import inputs.nixpkgs-stable ({
    config = config.nixpkgs.config;
    localSystem = { system = "x86_64-linux"; };
  });
  nur = (import inputs.NUR {
    pkgs = self;
    nurpkgs = self;
  }).repos;
}
