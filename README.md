# Nix+Bazel Codelab

## Background

This codelab is based on Google's [Bazel Codelab](https://github.com/bazelbuild/codelabs).
It has been adapted to

- Use more recent versions of the required Bazel rule sets.
- Follow best practices such as formatting with [`buildifier`][buildifier] or using `BUILD.bazel` files instead of `BUILD` files.
- Manage Go dependencies and targets using [Gazelle][gazelle].
- Use [Nix][nix] to provide Bazel and other developer tools in a Nix shell.
- Use [`rules_nixpkgs`][rules_nixpkgs] to import Nix provided toolchains from [`nixpkgs`][nixpkgs].

[buildifier]: https://github.com/bazelbuild/buildtools/blob/master/buildifier/README.md
[gazelle]: https://github.com/bazelbuild/bazel-gazelle
[nix]: https://nixos.org/
[rules_nixpkgs]: https://github.com/tweag/rules_nixpkgs
[nixpkgs]: https://github.com/NixOS/nixpkgs

## TODO

- [x] Base on `./generate_workspace.sh` and `./generate_build_files.sh`.
- [x] Format using `buildifier`.
- [x] Rename `BUILD` files to `BUILD.bazel`.
- [x] Update Bazel rule sets
- [x] Use Go mod to manage Go dependencies.
- [x] Use Gazelle to import Go dependencies and manage Go targets.
- [x] Update typescript targets for compatibility and use `concatjs` for development server.
- [x] Set up a Nix shell
- [x] Import toolchains using `rules_nixpkgs`.
- [ ] Test that the build succeeds on CI.
- [ ] Update the tutorial in this `README` and incorporate project layout.
- [ ] Update `./generate_workspace.sh` and `./generate_build_files.sh` to reflect the Nix based solution.
- [ ] Replace working `WORKSPACE` and `BUILD.bazel` content with placeholders to be a tutorial.
- [ ] Consider other options for testing the tutorial, perhaps [`byexample`][byexample].

[byexample]: https://byexamples.github.io/byexample/

## Project Layout

- `direnv` used to automatically set up shell environment, see [`.envrc`](./.envrc).
- Nix shell used to provide developer tools like Bazel itself, see [`shell.nix`](./shell.nix)
- Nix dependencies pinned under [`nix/`](./nix).
- Bazel layout
  - [`WORKSPACE`](./WORKSPACE) defines root of Bazel project and defines external dependencies
    - Uses `http_archive` to import Bazel dependencies
    - Uses `nixpkgs_package` to import Nix dependencies into Bazel
    - Uses other rule sets' dedicated repository rules to import their dependencies, e.g. Go or NodeJS.
  - `.bazelrc` configures Bazel
  - `BUILD.bazel` files define Bazel packages and targets in that package

## Before you get started

Read up on Bazel [Concepts and Terminology][concepts].

[concepts]: https://docs.bazel.build/versions/main/build-ref.html)

## Section 1: Hello, Bazel!

Build an example Java application that prints

``` plain
Hello, Bazel!
```

to the console.

1.  Edit `java/src/main/java/bazel/bootcamp/BUILD.bazel`
1.  Add a binary target for `HelloBazelBootcamp.java`
    - use [`java_binary`][java_binary]
    - name it `HelloBazelBootcamp`
1.  Run the binary using `bazel run //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp`

[java_binary]: https://docs.bazel.build/versions/master/be/java.html#java_binary

## Section 2: Go server

Build a Go server that receives log messages in the format defined in `proto/logger/logger.proto`.

1.  Edit `proto/logger/BUILD.bazel`
    1. Add a target for the protocol description
        - name it `logger_proto`
        - use [`proto_library`][proto_library]
        - ignore the deprecation warning in the   documentation, [the API is still valid][deprecated]
    1. Add a library target for a Go `protobuf` library based on `logger.proto`
        - name it `logger_go_proto`
        - use [`go_proto_library`][go_proto_library]
        - `compilers` and `importpath` are attributes specific to `protobuf` and Go respectively, check the linked examples for details.

[proto_library]: https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library
[deprecated]: https://github.com/bazelbuild/rules_proto/issues/50#issuecomment-602578288
[go_proto_library]: https://github.com/bazelbuild/rules_go/blob/master/proto/core.rst#example-grpc

1.  Edit `go/cmd/server/BUILD.bazel`
    1. Add a binary target from `server.go`
        - name it `go-server`
        - use [`go_binary`][go_binary]
        - add `//proto/logger:logger_go_proto` to `deps`
        - TODO: show how to use [Gazelle][gazelle] to generate dependencies
1.  Run the go binary using `bazel run //go/cmd/server:go-server`
    - `run` implies the `build` step
1.  Check [`http://localhost:8081`](http://localhost:8081)
    - it should display
      > "No log messages received yet."

[go_binary]: https://github.com/bazelbuild/rules_go/blob/master/docs/go/core/rules.md#rules

## Section 3: Java client

1.  Edit the `BUILD` file for `logger.proto`
    - [`java_proto_library` documentation](https://docs.bazel.build/versions/master/be/java.html#java_proto_library)
    - [`java_grpc_library` documentation](https://grpc.io/docs/reference/java/generated-code.html) (look towards the
      bottom of the page for Bazel related documentation)
1.  Edit the `BUILD` file for `JavaLoggingClientLibrary.java`
    - [`java_library` documentation](https://docs.bazel.build/versions/master/be/java.html#java_library)
1.  Edit the `BUILD` file for `JavaLoggingClient.java`
    - [`java_binary` documentation](https://docs.bazel.build/versions/master/be/java.html#java_binary)
1.  `bazel run` the Java binary you wrote
1.  `bazel run` the Go binary from Section 2
1.  Send messages from the client to the server and view them on http://localhost:8081

## Section 4: Java client unit tests
1.  Edit the `BUILD` file for `JavaLoggingClientLibraryTest.java`
    - [`java_test` documentation](https://docs.bazel.build/versions/master/be/java.html#java_test)
    <details> <summary>Hint</summary>Names matter for tests. The <code>java_test</code> for this file should be named <code>JavaLoggingClientLibraryTest</code></details>
1.  Edit the `BUILD` file for `JavaLoggingClientTest.java`
1.  Run the tests using `bazel test`

## Section 5: Typescript web frontend
1.  Edit the `WORKSPACE` to uncomment the typescript relevant portions
1.  Edit the `BUILD` file for `logger.proto`
    - [`ts_proto_library` documentation](https://www.npmjs.com/package/@bazel/typescript#ts_proto_library)
1.  Edit the `BUILD` file for `app.ts`
    - [`ts_library` usage example](https://www.npmjs.com/package/@bazel/typescript#compiling-typescript-ts_library) and        [`ts_library` documentation](https://www.npmjs.com/package/@bazel/typescript#ts_library)
1.  Run the webserver using `bazel run`. It will print out a link which you can click on.
    If the link doesn't work, go to http://localhost:8080 instead
1.  Run the Go server and Java client from the previous steps. Send messages from the Java
    client to the Go server and see them appear on the web frontend
## Section 6: Integration test
1.  Edit the `BUILD` file for `integrationtest.sh`
    - [`sh_test` documentation](https://docs.bazel.build/versions/master/be/shell.html#sh_test)
1.  Run the test using `bazel test` and make sure that it passes
1.  Run the test using `bazel test <target> --runs_per_test=10` and make sure that it passes
    <details> <summary>Hint</summary>You may need to modify the <code>BUILD</code> file again to make this work</details>

## Section 7: Query
1.  https://docs.bazel.build/versions/master/query-how-to.html


