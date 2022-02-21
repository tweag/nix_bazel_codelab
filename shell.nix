{ pkgs ? import ./nix/nixpkgs { } }:

with pkgs;

mkShell {
  buildInputs = [ bazel_4 buildifier buildozer nix ];
}
