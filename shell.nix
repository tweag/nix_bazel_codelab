{ pkgs ? import ./nix/nixpkgs { } }:

let
  lab-script = pkgs.writeShellScriptBin "lab" (builtins.readFile ./bin/lab);
in
with pkgs;

mkShell {
  buildInputs = [ bazel_4 buildifier buildozer nix ];
  packages = [ lab-script ];
}
