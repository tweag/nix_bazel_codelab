{ pkgs ? import ./nix/nixpkgs { } }:

let
  lab-script = pkgs.writeShellScriptBin "lab" (builtins.readFile ./bin/lab);
in
with pkgs;

mkShell {
  packages = [ bazel_7 bazel-buildtools nix ];
  JAVA_HOME = lib.makeLibraryPath [ openjdk19 ] + "/openjdk";
}
