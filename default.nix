let pkgs = import ./nix/nixpkgs.nix {}; in
rec {
    scramble = pkgs.callPackage ./scramble.nix {};
}
