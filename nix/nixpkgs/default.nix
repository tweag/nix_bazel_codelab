{ system ? builtins.currentSystem, ... }:

import (builtins.fetchTarball {
  name = "nixos-21.11-2021-12-04";
  # URL obtained from https://status.nixos.org/
  url = "https://github.com/NixOS/nixpkgs/archive/e34c5379866833f41e2a36f309912fa675d687c7.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "15shzr1wmc5770kblvlfwq5dsdlmvkpc3rhkn40nyi00fidqq96v";
}) {
  inherit system;
  overlays = [];
  config = {};
}
