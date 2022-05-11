{ pkgs, inputs }:
let
  system = "${pkgs.hostPlatform.system}";
  dream2nix = inputs.dream2nix.lib2.init {
    systems = [ "${system}" ];
    config = {
      overridesDirs = [ "${inputs.dream2nix}/overrides" ];
      projectRoot = ./.;
    };
  };
in
{
  haskell-hello-world = ((pkgs.haskell-nix.project' {
    src = ./haskell/hello-world;
    projectFileName = "stack.yaml";
  }).flake {}).packages;
  node-hello-world = (dream2nix.makeFlakeOutputs {
    source = ./node/hello-world;
  }).packages.${system}.hello-world;
  rust-hello-world = (dream2nix.makeFlakeOutputs {
    source = ./rust/hello-world;
  }).packages.${system}.hello-world;
}
