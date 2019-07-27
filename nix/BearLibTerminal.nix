{stdenv, cmake, libGL, xorg, tree}:
stdenv.mkDerivation {
    name = "BearLibTerminal";

    src = fetchTarball {
        url = "https://bitbucket.org/cfyzium/bearlibterminal/get/0.12.1.tar.gz";
        sha256 = "1j2y5yf5cp8dz4m5sm55cl99gvkjfk6qjq3ckif459zjwzlkl4g9";
    };

    buildInputs = [cmake libGL xorg.libX11 xorg.libXmu tree];

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
