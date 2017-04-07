with import <nixpkgs> {}; {
    BuckwheatJsEnv = stdenv.mkDerivation {
        name = "BuckwheatJsEnv";
        buildInputs = [ ghc stack ];
    };
}
