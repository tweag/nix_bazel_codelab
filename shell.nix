{ pkgs ? import ./nix/nixpkgs { } }:

let
  lab-script = pkgs.writeShellScriptBin "lab" (builtins.readFile ./bin/lab);
in
with pkgs;

mkShell {
  packages = [ lab-script bazel_7 bazel-buildtools nix ];
}
