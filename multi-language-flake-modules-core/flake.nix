{
  inputs = {
    nixpkgs.follows = "haskell-nix/nixpkgs-unstable";
    flake-modules-core = {
      url = "github:hercules-ci/flake-modules-core";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haskell-nix = {
      url = "github:input-output-hk/haskell.nix";
    };
    dream2nix = {
      url = "github:davhau/dream2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, flake-modules-core, ... }:
    (flake-modules-core.lib.evalFlakeModule
      { inherit self; }
      {
        systems = [ "x86_64-linux" ];
        imports = [
          ./rust/hello-world/flake-module.nix
          ./node/hello-world/flake-module.nix
          ./haskell/hello-world/flake-module.nix
        ];
      }
    ).config.flake;
}
