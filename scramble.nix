{stdenv, makeWrapper, BearLibTerminal, perl, rakudo}:
let
    libraryPath = stdenv.lib.makeLibraryPath [BearLibTerminal];
in
stdenv.mkDerivation {
    name = "scramble";
    buildInputs = [makeWrapper rakudo];
    phases = ["installPhase"];
    installPhase = ''
        mkdir --parents $out/bin $out/share

        cp -R ${./bin} $out/share/bin
        cp -R ${./lib} $out/share/lib
        cp -R ${./META6.json} $out/share/META6.json

        makeWrapper \
            ${rakudo}/bin/perl6 \
            $out/bin/scramble \
            --prefix LD_LIBRARY_PATH : ${libraryPath} \
            --prefix PERL6LIB , $out/share \
            --add-flags $out/share/bin/scramble

        makeWrapper \
            ${perl}/bin/prove \
            $out/bin/scramble.test \
            --prefix PERL6LIB , $out/share \
            --add-flags --exec \
            --add-flags ${rakudo}/bin/perl6 \
            --add-flags --recurse \
            --add-flags $out/share/t
    '';
}
