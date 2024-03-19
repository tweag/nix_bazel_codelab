{ system ? builtins.currentSystem, ... }:

import (builtins.fetchTarball {
  name = "nixos-24.05-2024-06-03";
  # URL obtained from https://status.nixos.org/
  url = "https://github.com/NixOS/nixpkgs/archive/805a384895c696f802a9bf5bf4720f37385df547.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "1q7y5ygr805l5axcjhn0rn3wj8zrwbrr0c6a8xd981zh8iccmx0p";
}) {
  inherit system;
  overlays = [];
  config = {};
}
