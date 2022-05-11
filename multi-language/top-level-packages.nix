{ pkgs, inputs }:
let
  callPackage = package: args: pkgs.callPackage package { inherit pkgs inputs; } // args;
in
{
  haskell-hello-world = callPackage ./haskell/hello-world {};
  node-hello-world = callPackage ./node/hello-world {};
  rust-hello-world = callPackage ./rust/hello-world {};
}
