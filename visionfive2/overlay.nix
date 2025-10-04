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
