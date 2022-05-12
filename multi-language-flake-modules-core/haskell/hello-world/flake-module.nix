{ self, ... }:
{
  perSystem = system: { config, self', inputs', ... }:
  let
    haskell-nix-pkgs = (import self.inputs.nixpkgs { inherit system; overlays = [ self.inputs.haskell-nix.overlay ]; });
  in
  {
    packages.haskell-hello-world = ((haskell-nix-pkgs.haskell-nix.project' {
      src = ./.;
      projectFileName = "stack.yaml";
    }).flake {}).packages."hello-world:exe:hello-world";
  };
  flake = {
    # Normal flake attributes
    z = "hello";
  };
}
