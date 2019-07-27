{stdenv, cmake, libGL, xorg}:
stdenv.mkDerivation {
    name = "BearLibTerminal";

    src = fetchTarball {
        # BearLibTerminal 0.15.7 isn't tagged so we refer to it by commit hash
        # instead.
        url = "https://bitbucket.org/cfyzium/bearlibterminal/get/a105007352d598bbc269c611970cca1eb014759c.tar.gz";
        sha256 = "127n00sfh0qd4npm9b2b4kzbpa26ayfjq5kgpqlaklmzbnccw80g";
    };

    buildInputs = [cmake libGL xorg.libX11 xorg.libXmu];

    # BearLibTerminal ships with examples. We don't need them, so we're not
    # going to compile them.
    patchPhase = ''
        rm -r Samples
    '';

    # BearLibTerminal doesn't ship an install target so we write our own
    # install phase instead.
    installPhase = ''
        mkdir --parents $out/lib
        mv ../Output/Linux64/libBearLibTerminal.so $out/lib
    '';
}
