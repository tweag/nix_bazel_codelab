# Nix+Bazel Codelab

This set of exercises is a practical introduction to building polyglot projects with Bazel, supported by Nix for reproducible, hermetic build environments. It is self-contained and works on Linux and macOS.

Please [open an issue](https://github.com/tweag/nix_bazel_codelab/issues/new/choose) if you have questions or encounter problems running the examples.

Please [make a pull request](https://github.com/tweag/nix_bazel_codelab/compare) if you found and fixed an issue.

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

## Project Layout

- [`direnv`][direnv] used to automatically set up shell environment, see [`.envrc`](./.envrc).
- Nix shell used to provide developer tools like Bazel itself, see [`shell.nix`](./shell.nix)
- Nix dependencies pinned under [`nix/`](./nix).
- Bazel layout
  - [`WORKSPACE`](./WORKSPACE) defines root of Bazel project and defines external dependencies
    - Uses `http_archive` to import Bazel dependencies
    - Uses `nixpkgs_package` to import Nix dependencies into Bazel
    - Uses other rule sets' dedicated repository rules to import their dependencies, e.g. Go or NodeJS.
  - `.bazelrc` configures Bazel
  - `BUILD.bazel` files define Bazel packages and targets in that package

[direnv]: https://github.com/direnv/direnv

## Check your files against a known solution

The repository contains bazel build files that are known to work, they are shipped in the [`solutions`](solutions) subdirectory of the project.

A script named `lab` is added to your environment with `nix-shell`, it helps using the solutions files.

`lab` can be used in multiple ways:
- `lab help` to get help and examples of use
- `lab compare $file` to view a difference between your file and the solution if exists
- `lab display $file` to view its solution if any
- `lab install $file` to copy the solution if any (this will replace your work!)
- `lab install_all` install all solutions file, the project should compile fine after running this command

## Before you get started

Read up on Bazel [Concepts and Terminology][concepts].

[concepts]: https://docs.bazel.build/versions/4.2.1/build-ref.html

## Running on NixOS

If your system is NixOS, uncomment the two lines in the `http_archive` named `rules_proto` in [WORKSPACE](WORKSPACE).

**Explanations**: A [a patch][rules_proto_nixos_patch] on `rules_proto` is needed on NixOS because they're currently using a prebuilt compiler, in which the linker is hardcoded to `/lib64/ld-linux-x86-64.so.2`.
The patch will instead force `rules_proto` to rebuild `protoc`, so we can link it properly.
Note that this solution is not ideal: optimally we would be getting `protoc` from `nixpkgs` and hooking it into `rules_proto`.

See [this issue][rules_proto_protoc_issue] for a discussion on the topic.

Hint: `http_archive` [supports][http_archive_attributes] applying patches to whatever it downloads.

[rules_proto_nixos_patch]: patches/rules_proto/nixos.patch
[http_archive_attributes]: https://bazel.build/rules/lib/repo/http#attributes
[rules_proto_protoc_issue]: https://github.com/bazelbuild/rules_proto/issues/115

## Install Nix and enter `nix-shell`

Install the [Nix package manager](https://nixos.org/explore.html) with

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

All commands from the instructions are expected to run in the environment created by entering

```sh
nix-shell
```

If you want to use your favorite shell (e.g. `fish`) installed on your system:

```sh
nix-shell --run fish
```

Use [`direnv`](https://direnv.net/) to automatically set up the environment when changing to this project's directory.

## Getting started

This project contains missing pieces that you will have to write, with some guidance, to make it compile again.

In the files that require editing, you will find comments such as `# section 1 code to add here`
helping you ensure that you are looking at the right place for the current exercise.

The `lab` script can be used if you need to compare your changes with the solution.

Feel free to ask the Bazel people for help on Slack if you have questions, or if you think something is wrong in the codelab.

## Section 1: Hello, Bazel!

Build an example Java application that prints

``` plain
Hello, Bazel!
```

to the console.

1.  Edit `java/src/main/java/bazel/bootcamp/BUILD.bazel`
1.  Add a binary target for `HelloBazelBootcamp.java`
    - use [`java_binary()`][java_binary]
    - name it `HelloBazelBootcamp`
1.  Run the binary using `bazel run //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp`

[java_binary]: https://docs.bazel.build/versions/4.2.1/be/java.html#java_binary

## Section 2: Go server

Build a Go server that receives log messages in the format defined in `proto/logger/logger.proto`.

1.  Edit `proto/logger/BUILD.bazel`
    1. Add a target for the protocol description
        - use [`proto_library()`][proto_library]
        - name it `logger_proto`
        - ignore the deprecation warning in the documentation, [the API is still valid][deprecated]
    1. Add a library target for a Go `protobuf` library based on `logger.proto`
        - use [`go_proto_library()`][go_proto_library]
            - name it `logger_go_proto`
            - `importpath`
                - allows importing the library from a known package path in `server.go`
            - `compilers`
                - setting to `["@io_bazel_rules_go//proto:go_grpc"]` builds functions implementing the `Logger` service for `gRPC`

[proto_library]: https://docs.bazel.build/versions/4.2.1/be/protocol-buffer.html#proto_library
[deprecated]: https://github.com/bazelbuild/rules_proto/issues/50#issuecomment-602578288
[go_proto_library]: https://github.com/bazelbuild/rules_go/blob/master/proto/core.rst#example-grpc

1.  Edit `go/cmd/server/BUILD.bazel`
    1. Add a binary target from `server.go`
        - use [`go_binary()`][go_binary]
        - name it `go-server`
        - add `//proto/logger:logger_go_proto` to `deps`
        - TODO: show how to use [Gazelle][gazelle] to generate dependencies
        - TODO: discuss separating `binary` and `library` for reuse
            - maybe add another exercise
1.  Run the go binary using `bazel run //go/cmd/server:go-server`
    - `run` implies the `build` step
1.  Check [`http://localhost:8081`](http://localhost:8081)
    - it should display
      > "No log messages received yet."

[go_binary]: https://github.com/bazelbuild/rules_go/blob/master/docs/go/core/rules.md#rules

## Section 3: Java client

Build a Java client which sends log messages to the server, in the format defined in `proto/logger/logger.proto`.

1.  Edit `proto/logger/BUILD.bazel`
    1. Add a Java library for data structurs in `logger.proto`
        - use [`java_proto_library()`][java_proto_library]
        - name it `logger_java_proto`
    2. Add a Java library implementing the `gRPC` service `Logger` defined in `logger.proto`
        - use [`java_grpc_library()`][java_grpc_library]
        - name it `logger_java_grpc`
1.  Edit `java/src/main/java/bazel/bootcamp/BUILD.bazel`
    1. Add a Java library implementing the logging client
        - use [`java_library()`](https://docs.bazel.build/versions/4.2.1/be/java.html#java_library)
        - name it `JavaLoggingClientLibrary`
        - use `JavaLoggingClientLibrary.java` as source
        - declare depencies on `*_proto` and `*_grpc` targets created in previous steps
        - since `JavaLoggingClientLibrary` uses the `io.grpc` package, you will also need to declare a dependency on `@io_grpc_grpc_java//core`, as well as a transport impementation such as `@io_grpc_grpc_java//netty`.
    2. Add a Java binary for the client
        - use [`java_binary()`](https://docs.bazel.build/versions/4.2.1/be/java.html#java_binary)
        - name it `JavaLoggingClient`
        - use `JavaLoggigClient.java` as source
        - declare a dependency on `JavaLoggingClientLibrary`
1.  Run the Java binary with
    ```
    bazel run //java/src/main/java/bazel/bootcamp:JavaLoggingClient
    ```
    - [workaround][workaround] for an [open `nixpkgs` issue on macOS][nixpkgs-issue]
      ```
      env CC=gcc bazel run //java/src/main/java/bazel/bootcamp:JavaLoggingClient
      ```
      Note that it will not work by fixing `CC` to either `clang` or `clang++`, as both `C` and `C++` dependencies are present!

1.  Run the Go binary from [Section 2](#section-2-go-server) from another `nix-shell`
1.  Type messages to send from the client to the server and view them on [`http://localhost:8081`](http://localhost:8081)

[java_proto_library]: https://docs.bazel.build/versions/4.2.1/be/java.html#java_proto_library
[java_grpc_library]: https://grpc.io/docs/languages/java/generated-code/#codegen
[workaround]: https://github.com/NixOS/nixpkgs/issues/150655#issuecomment-993695804
[nixpkgs-issue]: https://github.com/NixOS/nixpkgs/issues/150655

## Section 4: Java client unit tests

1.  Edit `java/src/main/java/bazel/bootcamp/BUILD.bazel`
    1. Add a test target for `JavaLoggingClientLibrary`
        - [`java_test()`](https://docs.bazel.build/versions/4.2.1/be/java.html#java_test)
        - name it `JavaLoggingClientLibraryTest`
            - names matter for tests!
            - target name, test class, and file name must be identical
        - use `JavaLoggingClientLibraryTest.java` as source
        - add `JavaLoggingClientLibrary` target from [Section 3](#section-3-java-client) as dependency
    2. Repeat the same for the client binary `JavaLoggingClient`
1.  Run tests
    - TODO: this is not a unit test, it depends on the server to make any sense (but passes without it, throwing an error message)! write a mock?
    - start Go server in another `nix-shell`, as in [Section 2](#section-2-go-server)
    - run Java client tests
      ```
      bazel test //java/src/main/java/bazel/bootcamp:JavaLoggingClientLibraryTest
      ```

## Section 5: Typescript web frontend

1.  Edit `proto/logger/BUILD.bazel`
    1. Add a TypeScript `protobuf` library implementing `logger.proto`
        - use [`ts_proto_library()`][ts_proto_library]
        - name it `logger_ts_proto`
1.  Edit `typescript/BUILD.bazel`
    1. Add a target for the TypeScript app `app.ts`
        - use [`ts_library()`][ts_project]
            - NOTE: the same interface applies as for `ts_project()`
        - add `logger_ts_proto` as a dependency
    2. Add a target for a development server
        - use [`concatjs_devserver()`][concatjs]
            - set `entry_module = "bootcamp/typescript/app"` to make it work correctly
        - name it `devserver`
        - add the `ts_library` target as dependency
1.  Run the webserver using `bazel run //typescript:devserver`
    - it will print a link which you can click on
    - if the link does not work, try [`http://localhost:5432`][http://localhost:5432]
1.  Run the Go server and Java client from the previous steps.
    - send messages from the Java client to the Go server
    - click the button on the web front end to see them in your web browser

[ts_proto_library]: https://github.com/bazelbuild/rules_nodejs/tree/4.4.6/packages/labs/grpc_web
[ts_project]: https://www.npmjs.com/package/@bazel/typescript#user-content-typical-usage
[concatjs]: https://www.npmjs.com/package/@bazel/concatjs#user-content-serving-js-in-development-mode-under-bazel

## Section 6: Integration test

1.  Edit `tests/BUILD.bazel`
    - add a shell test target for `integrationtest.sh`
    - use [`sh_test`][sh_test]
    - add the Go server and Java client targets from previous steps as `data` dependencies
1.  Run the test using `bazel test` and make sure that it passes
1.  Run the test multiple times using `bazel test <target> --runs_per_test=10`
    - Does it pass? If not, can you figure out why?
    - Hint: the section on test run behaviour in the [`tags` documentation](tags_docs) may prove useful.

[sh_test]: https://docs.bazel.build/versions/4.2.1/be/shell.html#sh_test
[tags_docs]: https://docs.bazel.build/versions/4.2.1/be/common-definitions.html#common.tags

## Section 7: Query dependency graph

1. Read the [Bazel Query How-To][query] and try the examples to display the dependency graph of the packages in this exercise.

[query]: https://docs.bazel.build/versions/4.2.1/query-how-to.html


