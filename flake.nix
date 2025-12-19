{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/25.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import "${nixpkgs}" { inherit system; };
      in {
        packages.default = pkgs.haskell.packages.ghc967.callCabal2nix
          "github-app" ./.
          { };
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.ghcid
            pkgs.cabal-install
            pkgs.hpack
            (pkgs.haskell.packages.ghc967.ghc.withPackages (p:
              self.packages.${system}.default.getBuildInputs.haskellBuildInputs
            ))
            (pkgs.haskell-language-server.override {
              supportedGhcVersions = [ "967" ];
            })
          ];
        };
      });
}
