{ system ? builtins.currentSystem, ... }:

import (builtins.fetchTarball {
  name = "nixos-23.11-2024-03-17";
  # URL obtained from https://status.nixos.org/
  url = "https://github.com/NixOS/nixpkgs/archive/614b4613980a522ba49f0d194531beddbb7220d3.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "1kipdjdjcd1brm5a9lzlhffrgyid0byaqwfnpzlmw3q825z7nj6w";
}) {
  inherit system;
  overlays = [];
  config = {};
}
