self: super: 
let overrideSphinx = sphinx: sphinx.overrideAttrs (self: super: {
  doCheck = false;
  doInstallCheck = false;
  disabledTests = super.disabledTests ++ [
    "test_defaults"
    "test_check_link_response_only"
    "test_anchors_ignored_for_url"
    "test_connect_to_selfsigned_fails"
    "test_connect_to_selfsigned_with_tls_verify_false"
    "test_connect_to_selfsigned_with_tls_cacerts"
    "test_connect_to_selfsigned_with_requests_env_var"
    "test_linkcheck_allowed_redirects"
  ];
  });
   disableTests = pkg: pkg.overrideAttrs (self: super: { doCheck = false; });
   disablePythonTests = pkg: pkg.overridePythonAttrs (old: {
     doCheck = false;
     doInstallCheck = false;
     checkPhase = "true";
   });
in {
  libuv = disableTests super.libuv;
  libopus = disableTests super.libopus;
  openldap = disableTests super.openldap;
  dconf = disableTests super.dconf;
  valgrind = disableTests super.valgrind;
  valgrind-light = disableTests super.valgrind-light;
  libwacom = super.libwacom.overrideAttrs (self: super: {
    doCheck = false;
    mesonFlags = [ "-Dtests=disabled" ];
  });
  llvmPackages_15 = super.lib.updateManyAttrsByPath [
    {
      path = [ "libllvm" ];
      update = old: old.overrideAttrs (self: super: { doCheck = false; });
    }
    {
      path = [ "llvm" ];
      update = old: old.overrideAttrs (self: super: { doCheck = false; });
    }
  ] super.llvmPackages_15;
  llvmPackages_20 = super.lib.updateManyAttrsByPath [
    {
      path = [ "libllvm" ];
      update = old: old.overrideAttrs (self: super: { doCheck = false; });
    }
    {
      path = [ "llvm" ];
      update = old: old.overrideAttrs (self: super: { doCheck = false; });
    }
  ] super.llvmPackages_20;
  tracker = disableTests super.tracker;
  openexr = disableTests super.openexr;
  openexr_3 = disableTests super.openexr_3;
  bind = disableTests super.bind;
  libpsl = disableTests super.libpsl;
  libhwy = disableTests super.libhwy;
  gjs = disableTests super.gjs;
  gobject-introspection-unwrapped = disableTests super.gobject-introspection-unwrapped;
  json-glib = disableTests super.json-glib;
  x265 = super.x265.override { unittestsSupport = false; };
  meson = super.meson.overrideAttrs (curr: prev: { doInstallCheck = false; });
  libarchive = super.libarchive.overrideAttrs (curr: prev: {
    postPatch = let
      skipTestPaths = [
        # test won't work in nix sandbox
        "libarchive/test/test_write_disk_perms.c"
        # the filesystem does not necessarily have sparse capabilities
        "libarchive/test/test_sparse_basic.c"
        # the filesystem does not necessarily have hardlink capabilities
        "libarchive/test/test_write_disk_hardlink.c"
        # idk, doesn't work
        "libarchive/test/test_acl_platform_posix1e.c"
        # access-time-related tests flakey on some systems
        "cpio/test/test_option_a.c"
        "cpio/test/test_option_t.c"
      ];
      removeTest = testPath: ''
        substituteInPlace Makefile.am --replace "${testPath}" ""
        rm "${testPath}"
      '';
    in ''
      substituteInPlace Makefile.am --replace '/bin/pwd' "$(type -P pwd)"

      ${super.lib.concatStringsSep "\n" (map removeTest skipTestPaths)}
    '';
  });
  cryptsetup = disableTests super.cryptsetup;
  verilog = super.verilog.overrideAttrs (self: super: { doInstallCheck = false; });
  btrfs-progs = super.btrfs-progs.overrideAttrs (curr: prev: {
    nativeBuildInputs = [ super.pkg-config ] ++
      [
        (self.buildPackages.python3.withPackages (ps: with ps; [
          self.python3Packages.sphinx
          self.python3Packages.sphinx-rtd-theme
        ]))
      ];
  });

  python3Packages = super.python3Packages.overrideScope (self: super: {
    sphinx = overrideSphinx super.sphinx;
    pytest-timeout = disablePythonTests super.pytest-timeout;
    hypothesis = disablePythonTests super.hypothesis;
    numpy = super.numpy.overridePythonAttrs (old: {
      nativeCheckInputs = old.nativeCheckInputs ++ [ self.hypothesis ];
    });
    chardet = super.chardet.overridePythonAttrs (old: {
      nativeCheckInputs = old.nativeCheckInputs ++ [ self.hypothesis ];
    });
    eventlet = disableTests super.eventlet;
    watchdog = super.watchdog.overridePythonAttrs (old: {
      disabledTests = [ "test_select_fd" ];
    });
    werkzeug = super.werkzeug.overridePythonAttrs (old: {
      nativeCheckInputs = old.nativeCheckInputs ++ [ self.watchdog ];
    });
  });
  harfbuzz = disableTests super.harfbuzz;
  pixman = disableTests super.pixman;
  swtpm = disableTests super.swtpm;
  coreutils = disableTests super.coreutils;
  findutils = disableTests super.findutils;
  coreutils-full = disableTests super.coreutils-full;
  tailscale = disableTests super.tailscale;
  libadwaita = disableTests super.libadwaita;
}
