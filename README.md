# Nix+Bazel Codelab

This set of exercises is a practical introduction to building polyglot projects with Bazel, supported by Nix for reproducible, hermetic build environments. It is self-contained and works on Linux and macOS.

Please [open an issue](https://github.com/tweag/nix_bazel_codelab/issues/new/choose) if you have questions or encounter problems running the examples.

Please [make a pull request](https://github.com/tweag/nix_bazel_codelab/compare) if you found and fixed an issue.

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

- [`direnv`][direnv] used to automatically set up shell environment, see [`.envrc`](./.envrc).
- Nix shell used to provide developer tools like Bazel itself, see [`shell.nix`](./shell.nix)
- Nix dependencies pinned under [`nix/`](./nix).
- Bazel layout
  - [`MODULE.bazel`](./MODULE.bazel) defines root of Bazel project and defines external module dependencies
    - Uses `bazel_dep` to import Bazel dependencies from the [Bazel Central Registry (BCR)][bcr]
    - Uses `register_toolchains` to register toolchains from nixpkgs
    - Uses `use_repo` to bring repositories into scope
    - Uses other rule sets' dedicated module extensions to import their dependencies, e.g. Go or NodeJS.
  - [`non_module_dependencies.bzl`](./non_module_dependencies.bzl) contains legacy WORKSPACE rules that are not available as native module extensions
    - Uses `nixpkgs_*_configure` to create toolchains
    - Can use `http_archive` to import Bazel dependencies
    - Can use `nixpkgs_package` to import Nix dependencies into Bazel
    - Can use other rule sets' dedicated repository rules to import their dependencies
  - `.bazelrc` configures Bazel
  - `BUILD.bazel` files define Bazel packages and targets in that package

[direnv]: https://github.com/direnv/direnv
[bcr]: https://registry.bazel.build/

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

[concepts]: https://bazel.build/concepts/build-ref

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

Feel free to open an issue to ask questions, or if you think something is wrong in the codelab.

## Section 1: Hello, Bazel!

Build an example Java application that prints

``` plain
Welcome to the Bootcamp! Let's get going :)
```

to the console.

1.  Edit `java/src/main/java/bazel/bootcamp/BUILD.bazel`
1.  Add a binary target for `HelloBazelBootcamp.java`
    - use [`java_binary()`][java_binary]
    - name it `HelloBazelBootcamp`
1.  Run the binary using `bazel run //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp`
    - WARNING: The first time you run this command, it may take quite a long time.
      Bazel is downloading and installing all the dependencies required to build a Java project.

[java_binary]: https://bazel.build/reference/be/java#java_binary

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
                - setting to `["@rules_go//proto:go_grpc"]` builds functions implementing the `Logger` service for `gRPC`
1.  Edit `go/cmd/server/BUILD.bazel`
    1. The [`go_library`][go_library] target `server_lib` is already written for you
    1. Add a binary target from `server.go`
        - use [`go_binary()`][go_binary]
        - name it `go-server`
        - it should be compiled together with the sources of `server_lib`
1.  Run the go binary using `bazel run //go/cmd/server:go-server`
    - `run` implies the `build` step
1.  Check [`http://localhost:8081`](http://localhost:8081)
    - it should display
      > "No log messages received yet."


[proto_library]: https://bazel.build/reference/be/protocol-buffer#proto_library
[deprecated]: https://github.com/bazelbuild/rules_proto/issues/50#issuecomment-602578288
[go_proto_library]: https://github.com/bazelbuild/rules_go/blob/master/proto/core.rst#example-grpc
[go_binary]: https://github.com/bazelbuild/rules_go/blob/master/docs/go/core/rules.md#rules
[go_library]: https://github.com/bazelbuild/rules_go/blob/master/docs/go/core/rules.md#go_library

## Section 3: Java client

Build a Java client which sends log messages to the server, in the format defined in `proto/logger/logger.proto`.

1.  Edit `proto/logger/BUILD.bazel`
    1. Add a Java library for data structures in `logger.proto`
        - use [`java_proto_library()`][java_proto_library]
        - name it `logger_java_proto`
    2. Add a Java library implementing the `gRPC` service `Logger` defined in `logger.proto`
        - use [`java_grpc_library()`][java_grpc_library]
        - name it `logger_java_grpc`
1.  Edit `java/src/main/java/bazel/bootcamp/BUILD.bazel`
    1. Add a Java library implementing the logging client
        - use [`java_library()`](https://bazel.build/reference/be/java#java_library)
        - name it `JavaLoggingClientLibrary`
        - use `JavaLoggingClientLibrary.java` as source
        - declare depencies on `*_proto` and `*_grpc` targets created in previous steps
        - since `JavaLoggingClientLibrary` uses the `io.grpc` package, you will also need to declare a dependency on `@grpc-java//core`, as well as a transport impementation such as `@grpc-java//netty`.
    2. Add a Java binary for the client
        - use [`java_binary()`](https://bazel.build/reference/be/java#java_binary)
        - name it `JavaLoggingClient`
        - use `JavaLoggingClient.java` as source
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

[java_proto_library]: https://bazel.build/reference/be/java#java_proto_library
[java_grpc_library]: https://grpc.io/docs/languages/java/generated-code/#codegen
[workaround]: https://github.com/NixOS/nixpkgs/issues/150655#issuecomment-993695804
[nixpkgs-issue]: https://github.com/NixOS/nixpkgs/issues/150655

## Section 4: Java client unit tests

1.  Edit `java/src/main/java/bazel/bootcamp/BUILD.bazel`
    1. Add a test target for `JavaLoggingClientLibrary`
        - [`java_test()`](https://bazel.build/reference/be/java#java_test)
        - name it `JavaLoggingClientLibraryTest`
            - names matter for tests!
            - target name, test class, and file name must be identical
        - use `JavaLoggingClientLibraryTest.java` as source
        - add `JavaLoggingClientLibrary` target from [Section 3](#section-3-java-client) as dependency
    2. Repeat the same for the client binary `JavaLoggingClient`
1.  Run tests
    - NOTE: this is not a unit test, it depends on the server to make any sense.
        - If you skipped section 2 exercise, you can simply run `lab install go/cmd/server/BUILD.bazel` to get the solution of this exercise and `bazel run //go/cmd/server:go-server` to run it.
    - start Go server in another `nix-shell`, as in [Section 2](#section-2-go-server)
    - run Java client tests
      ```
      bazel test //java/src/main/java/bazel/bootcamp:JavaLoggingClientLibraryTest
      ```
        - NOTE: If you simply turn off the server and rerun the test,
            you will most likely see that the test passed, with the information that it is "cached".
            Indeed, Bazel does not rerun the tests if none of its dependencies changed.
            If you really want to rerun it to acknowledge that it fails when the server is off,
            you have to specify `--cache_test_results=no` in the command line.
    - Do not forget to run the tests of `JavaLoggingClient`
        - NOTE: Those tests do not use the server.

## Section 5: Typescript web frontend

1.  Edit `proto/logger/BUILD.bazel`
    1. Add a TypeScript `protobuf` library implementing `logger.proto`
        - use [`ts_proto_library()`][ts_proto_library]
        - name it `logger_ts_proto`
1.  Edit `typescript/BUILD.bazel`
    1. Add a target for the TypeScript app `app.ts`
        - use [`ts_project()`][ts_project]
        - add `logger_ts_proto` as a dependency
        - set `transpiler = "tsc"`
        - you need to reference the local tsconfig.json
    2. Bundle the JavaScript modules using esbuild
        - use [esbuild()][esbuild]
        - name it `bundle`
        - set a valid entrypoint (ts_project generates a file with the ending `.js`)
    2. Add a target for a development server
        - use [`js_run_devserver()`][js_run_devserver]
        - name it `devserver`
        - add the `esbuild` target and `index.html` as `data` dependencies
        - set `args = ["typescript"]` to serve files from the `typescript` directory
        - set `tool = ":http_server"` to make it work correctly
1.  Run the webserver using `bazel run //typescript:devserver`
    - it will print a link which you can click on
    - if the link does not work, try [`http://localhost:5432`](http://localhost:5432)
1.  Run the Go server and Java client from the previous steps.
    - send messages from the Java client to the Go server
    - click the button on the web front end to see them in your web browser

[ts_proto_library]: https://docs.aspect.build/rulesets/aspect_rules_ts/docs/proto/#ts_proto_library
[ts_project]: https://docs.aspect.build/rulesets/aspect_rules_ts/docs/rules#ts_project
[esbuild]: https://docs.aspect.build/rulesets/aspect_rules_esbuild/docs/rules
[js_run_devserver]: https://docs.aspect.build/rulesets/aspect_rules_js/docs/js_run_devserver/

## Section 6: Integration test

1.  Edit `tests/BUILD.bazel`
    - add a shell test target for `integrationtest.sh`
    - use [`sh_test`][sh_test]
    - add the Go server and Java client targets from previous steps as `data` dependencies
1.  Run the test using `bazel test <target>` and make sure that it passes
    - NOTE: You may have to modify your solution of Section 2 and 3 to make those tests pass.
        In particular, you most likely did not set the [visibility] of the binaries.
1.  Run the test multiple times using `bazel test <target> --runs_per_test=10`
    - QUESTION: Does it pass? If not, can you figure out why?
    - HINT: the section on test run behaviour in the [`tags` documentation][tags_docs] may prove useful.

[sh_test]: https://bazel.build/reference/be/shell#sh_test
[tags_docs]: https://bazel.build/reference/be/common-definitions#common.tags
[visibility]: https://bazel.build/concepts/visibility

## Section 7: Code formatting with buildifier

1. Edit `BUILD.bazel`
    1. Add a `load` instruction to import the rule [`buildifier`][buildifier].
       - NOTE: the documentation linked above assumes the use of the upstream buildifier rules.
         This project currently depends on a [fork][buildifier_prebuilt] that ships precompiled binaries
         and is already available as a [Bazel module][buildifier_prebuilt_bcr].
    1. Create a target called `buildifier-print` which warns about lint error and only prints the changes `buildifier` would make.
        - NOTE: Adding such a rule will provide a warning that using `mode = "diff"` is deprecated,
            and suggesting to use a `buildifier_test` rule instead.
            There is a [known issue][buildifier_test issue] preventing a `buildifier_test` from being run on every folders of a project, hence, for now, let's simply ignore this deprecation warning.
    1. Now create a target called `buildifier-fix` which fixes all the formatting errors (including linting ones).
    1. Run the 2 targets to format your solution to the exercises.

[buildifier_prebuilt]: https://github.com/keith/buildifier-prebuilt
[buildifier_prebuilt_bcr]: https://registry.bazel.build/modules/buildifier_prebuilt
[buildifier]: https://github.com/bazelbuild/buildtools/blob/master/buildifier/README.md
[buildifier_test issue]: https://github.com/bazelbuild/buildtools/issues/1075

## Section 8: Query dependency graph

1. Read the [Bazel Query How-To][query] and try the examples to display the dependency graph of the packages in this exercise.
1. SOLUTION: This exercise is solved [here](solutions/dependency_graph/README.md).

[query]: https://bazel.build/query/quickstart
