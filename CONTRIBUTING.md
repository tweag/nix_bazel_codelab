# Contribution guide

## Background

This codelab is based on Google's [Bazel Codelab](https://github.com/bazelbuild/codelabs).
It has been adapted to

- Use more recent versions of the required Bazel rule sets.
- Follow best practices such as formatting with [`buildifier`][buildifier] or using `BUILD.bazel` files instead of `BUILD` files.
- Use [Nix][nix] to provide Bazel and other developer tools in a Nix shell.
- Use [`rules_nixpkgs`][rules_nixpkgs] to import Nix provided toolchains from [`nixpkgs`][nixpkgs].

[buildifier]: https://github.com/bazelbuild/buildtools/blob/master/buildifier/README.md
[nix]: https://nixos.org/
[rules_nixpkgs]: https://github.com/tweag/rules_nixpkgs
[nixpkgs]: https://github.com/NixOS/nixpkgs

## Project Layout

- [`direnv`][direnv] used to automatically set up shell environment, see [`.envrc`](/.envrc).
- Nix shell used to provide developer tools like Bazel itself, see [`shell.nix`](/shell.nix)
- Nix dependencies pinned under [`nix/`](/nix).
- Bazel layout
  - [`WORKSPACE`](/WORKSPACE) defines root of Bazel project and defines external dependencies
    - Uses `http_archive` to import Bazel dependencies
    - Uses `nixpkgs_package` to import Nix dependencies into Bazel
    - Uses other rule sets' dedicated repository rules to import their dependencies, e.g. Go or NodeJS.
  - `.bazelrc` configures Bazel
  - `BUILD.bazel` files define Bazel packages and targets in that package

[direnv]: https://github.com/direnv/direnv
