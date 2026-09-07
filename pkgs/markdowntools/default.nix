{ lib, stdenv, makeWrapper, coreutils, pandoc, w3m, texliveSmall, ... }:

stdenv.mkDerivation rec {
    pname = "mdview";
    version = "0.1";

    buildInputs = [ coreutils pandoc w3m texliveSmall ];
    nativeBuildInputs = [ makeWrapper ];

    src = ./src;
    dontUnpack = true;
    installPhase = ''
        runHook preInstal
        mkdir -p $out/bin
        install $src/mdview.sh $out/bin/mdview
        wrapProgram $out/bin/mdview \
            --set PATH ${lib.makeBinPath [ pandoc w3m ]}
        install $src/md2pdf.sh $out/bin/md2pdf
        wrapProgram $out/bin/md2pdf \
            --set PATH ${lib.makeBinPath [ coreutils pandoc texliveSmall ]}
        runHook postInstall
    '';
}
