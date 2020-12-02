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

  tdlib = old.tdlib.overrideAttrs (oldAttrs: rec {
    version = "1.7.0";

    src = self.fetchFromGitHub {
      owner = "tdlib";
      repo = "td";
      rev = "v${version}";
      sha256 = "sha256-sZzp9k7KDnqftcSGSgXkIy0siCksGPBmRckySU/J0TU=";
    };
  });

  stable = import inputs.nixpkgs-stable ({
    config = config.nixpkgs.config;
    localSystem = { system = "x86_64-linux"; };
  });
}
