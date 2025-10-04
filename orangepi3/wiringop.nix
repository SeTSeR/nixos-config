{
  lib,
  stdenv,
  symlinkJoin,
  fetchFromGitHub,
  libxcrypt,
}:
let
  version = "0.2";
  mkSubProject =
    {
      subprj, # The only mandatory argument
      buildInputs ? [ ],
      preInstallPhase ? "",
      src ? fetchFromGitHub {
        owner = "orangepi-xunlong";
        repo = "wiringOP";
        rev = "v${version}";
        sha256 = "sha256-1mPukCF6Ux585lQY/n2NmIYyr/nOs2GrUqjJz1+TRmI=";
      },
    }:
    stdenv.mkDerivation rec {
      pname = "wiringop-${subprj}";
      inherit version src;
      sourceRoot = "${src.name}/${subprj}";
      inherit buildInputs;
      # Remove (meant for other OSs) lines from Makefiles
      preInstall = ''
        sed -i "/chown root/d" Makefile
        sed -i "/chmod/d" Makefile
      ''
      + preInstallPhase;
      makeFlags = [
        "DESTDIR=${placeholder "out"}"
        "PREFIX=/."
        # On NixOS we don't need to run ldconfig during build:
        "LDCONFIG=echo"
        "BOARD=orangepi3-h6"
      ];
    };
  passthru = {
    inherit mkSubProject;
    wiringPi = mkSubProject {
      subprj = "wiringPi";
      buildInputs = [
        libxcrypt
      ];
    };
    devLib = mkSubProject {
      subprj = "devLib";
      buildInputs = [
        passthru.wiringPi
      ];
    };
    wiringPiD = mkSubProject {
      subprj = "wiringPiD";
      buildInputs = [
        libxcrypt
        passthru.wiringPi
        passthru.devLib
      ];
    };
    gpio = mkSubProject {
      subprj = "gpio";
      buildInputs = [
        libxcrypt
        passthru.wiringPi
        passthru.devLib
      ];
      preInstallPhase = "mkdir -p $out/bin";
    };
  };
in
symlinkJoin {
  name = "wiringop-${version}";
  inherit passthru;
  paths = [
    passthru.wiringPi
    passthru.devLib
    passthru.wiringPiD
    passthru.gpio
  ];
  meta = with lib; {
    description = "wiringPi for Orange Pi";
    homepage = "https://github.com/orangepi-xunlong/wiringOP";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ setser ];
    platforms = platforms.linux;
  };
}
