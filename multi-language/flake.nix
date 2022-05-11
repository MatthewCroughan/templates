{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    haskell-nix.url = "github:input-output-hk/haskell.nix";
    dream2nix = {
      url = "github:davhau/dream2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, dream2nix, haskell-nix }@inputs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forSystems = systems: f:
        nixpkgs.lib.genAttrs systems
        (system: f system (import nixpkgs { inherit system; overlays = [ haskell-nix.overlay ]; }));
      forAllSystems = forSystems supportedSystems;
    in
    {
      packages = forAllSystems (system: pkgs: import ./top-level.nix { inherit pkgs inputs; } );
#      devShells = forAllSystems (system: pkgs: import ./top-level-devshells.nix { inherit pkgs inputs; } );
    };
}
