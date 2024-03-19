{ pkgs }:

let
  imgLink = "https://w.wallhaven.cc/full/2y/wallhaven-2yoo1m.jpg";

  img = pkgs.fetchurl {
    url = imgLink;
    sha256 = "1gv942ybms4lwczlx3niz9wl3pg4iby3zdyjx68spdxng7cfh9bg";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "3ximus";
    repo = "aerial-sddm-theme";
    rev = "74fb9d0b2cfc3b63f401606b416e908a71efc447";
    sha256 = "0r52rr68am383nxhg86d61n1lv6mbbmfrga94ayynkxfbnz2fxjx";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm background.jpg
    cp -r ${img} $out/background.jpg
  '';
}
