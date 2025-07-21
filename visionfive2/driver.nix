{ fetchurl, stdenv, lib, autoPatchelfHook, libdrm }:
stdenv.mkDerivation rec {
  pname = "img-visionfive2-gpu";
  version = "1.19.6345021";
  src = fetchurl {
    url = "https://github.com/starfive-tech/soft_3rdpart/raw/JH7110_VisionFive2_devel/IMG_GPU/out/img-gpu-powervr-bin-${version}.tar.gz";
    sha256 = "sha256-ncryCEsT5ZxOUKSiiPXeVvjp7mMWJ6PoGFkWdb9hMRo=";
	};

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ stdenv.cc.cc libdrm ];

  buildPhase = "";

  installPhase = ''
    mkdir $out
    cp -R target/etc $out/etc
    cp -R target/lib $out/lib
    cp -R target/usr $out/usr
  '';
}
