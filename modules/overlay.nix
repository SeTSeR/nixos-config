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

  tdlib = old.tdlib.overrideAttrs (oldAttrs: {
    version = "1.6.9";

    src = self.fetchFromGitHub {
      owner = "tdlib";
      repo = "td";
      rev = "30921606c5a5ea4c31193adcbb457cce4503751d";
      sha256 = "sha256-Lcu0zZqbO/wVS6jnRsw15rkQ/8B8StcAmOVSreN4rfQ=";
    };
  });

  stable = import inputs.nixpkgs-stable ({
    config = config.nixpkgs.config;
    localSystem = { system = "x86_64-linux"; };
  });
}
