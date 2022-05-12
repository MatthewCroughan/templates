{ self, ... }:
{
  perSystem = system: { config, self', inputs', ... }:
    let
      dream2nix = self.inputs.dream2nix.lib2.init {
        systems = [ "${system}" ];
        config.projectRoot = ./.;
      };
    in
  {
    packages.node-hello-world = (dream2nix.makeFlakeOutputs {
      source = ./.;
    }).packages.${system}.hello-world;
  };
  flake = {
    # Normal flake attributes
    y = "hello";
  };
}
