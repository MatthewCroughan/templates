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
(dream2nix.makeFlakeOutputs {
  source = ./.;
}).packages.${system}.hello-world
