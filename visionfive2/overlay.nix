self: super:
let
  disableTests = pkg: pkg.overrideAttrs (self: super: { doCheck = false; });
in
{
  libpng = super.libpng.overrideAttrs (
    finalAttrs: prevAttrs: {
      configureFlags = [
        "--disable-riscv-rvv"
        "--enable-apng"
      ];
    }
  );
  libsecret = disableTests super.libsecret;
  ffmpeg = super.ffmpeg.override { withSdl2 = false; };
  tailscale = super.tailscale.overrideAttrs (
    self: super: {
      src = super.src.overrideAttrs (prev: {
        patches = [ ./tailscale/tailscale-disable-bolt.patch ];
      });
    }
  );
  bmake = super.bmake.overrideAttrs (self: super: {
    env.BROKEN_TESTS = super.env.BROKEN_TESTS + " cmd-interrupt";
  });
  tbb_2022 = super.tbb_2022.overrideAttrs (finalAttrs: prevAttrs: {
    patches = prevAttrs.patches ++ [
      (super.fetchpatch {
        url = "https://github.com/uxlfoundation/oneTBB/commit/65d46656f56200a7e89168824c4dbe4943421ff9.patch?full_index=1";
        hash = "sha256-hhHDuvUsWSqs7AJ5smDYUP1yYZmjV2VISBeKHcFAfG4=";
      })
      (super.fetchpatch {
        url = "https://github.com/uxlfoundation/oneTBB/commit/e57411968661ab1205322ba1c84fc1cd90a306c6.patch";
        hash = "sha256-PFixW4lYqA5oy4LSwewvxgJbjVKJceRHnp8mgW9zBF0=";
      })
    ];
  });
  swtpm = disableTests super.swtpm;
  python3 = super.python3.override {
    packageOverrides = pyself: pysuper: {
      virtualenv = pysuper.virtualenv.overridePythonAttrs (oldAttrs: {
        disabledTests = oldAttrs.disabledTests ++ [ "test_too_many_open_files" ];
      });
    };
  };
  python3Packages = super.python3Packages.overrideScope (
    self: super: {
      virtualenv = super.virtualenv.overridePythonAttrs (oldAttrs: {
        disabledTests = oldAttrs.disabledTests ++ [ "test_too_many_open_files" ];
      });
    }
  );
}
