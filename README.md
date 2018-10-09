# This repository contains the completed source code, but no BUILD files, for the Bazel Bootcamp to be presented at BazelCon 2018.

## Section 1: Hello, Bazel!

1.  Edit: `java/src/main/java/bazel/bootcamp/BUILD`
1.  Add a `java_binary` target for the `HelloBazelBootcamp.java` file
1.  Documentation: https://docs.bazel.build/versions/master/be/java.html#java_binary
1.  Run the binary using `bazel run //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp`

## Section 2: Go server
1.  Edit the `BUILD` file for `logger.proto`
1.  Documentation: https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library
1.  Documentation: https://github.com/bazelbuild/rules_go/blob/master/proto/core.rst#go_proto_library
    - Hint: Check out the `compilers` attribute for `go_proto_library`
1.  Edit the `BUILD` file for `server.go`
1.  Documentation: https://github.com/bazelbuild/rules_go/blob/master/go/core.rst#go_binary    
1.  Run the go binary using `bazel run`
1.  Go to http://localhost:8081 to see results (there won't be any logs yet)

## Section 3: Java client

1.  Edit the `BUILD` file for `JavaLoggingClientLibrary.java`
1.  Documentation: https://docs.bazel.build/versions/master/be/java.html#java_library
1.  Edit the `BUILD` file for `JavaLoggingClient.java`
1.  Documentation: https://docs.bazel.build/versions/master/be/java.html#java_binary
1.  `bazel run` the Java binary you wrote
1.  `bazel run` the Go binary from Section 2
1.  Send messages from the client to the server and view them on http://localhost:8081

## Section 4: Java client unit tests
1.  Edit the `BUILD` file for `JavaLoggingClientLibraryTest.java`
    - Hint: Names matter for tests. The `java_test()` for this file should be named `JavaLoggingClientLibraryTest`
1.  Edit the `BUILD` file for `JavaLoggingClientTest.java`
1.  Documentation: https://docs.bazel.build/versions/master/be/java.html#java_test
1.  Run the tests using `bazel test`

## Section 5: Typescript web frontend
1.  Edit the `WORKSPACE` file to add the typescript external dependencies following steps
    from here: https://github.com/alexeagle/ts-from-bazel/blob/master/README.md. Note that
    those instructions assume that you are starting with an empty project. So you will need
    to add the listed dependencies to the WORKSPACE file, but you don't need to run the
    commands to generate the files like `yarn.lock` or `package.json`. Check the existing
    project to see what is present. 
1.  Edit the `BUILD` file for `app.ts`
1.  Documentation: https://github.com/bazelbuild/rules_typescript#usage
1.  Run the webserver using `bazel run`. It will print out a link which you can click on.
    If the link doesn't work, go to http://localhost:8080 instead
1.  Run the Go server and Java client from the previous steps. Send messages from the Java
    client to the Go server and see them appear on the web frontend
    
## Section 6: Integration test
1.  Edit the `BUILD` file for `integrationtest.sh`
1.  Documentation: https://docs.bazel.build/versions/master/be/shell.html#sh_test
1.  Run the test using `bazel test` and make sure that it passes
1.  Run the test using `bazel test <target> --runs_per_test=10` and make sure that it passes

## Section 7: Query
1.  https://docs.bazel.build/versions/master/query-how-to.html

## Section X: Android

1.  (Install android studio)[https://developer.android.com/studio/install#linux]
    Follow the steps and make sure you also install the SDK during this process.
1.  Use the avd manager (Tools > AVD Manager) to create a virtual device (pixel
    with oreo is fine). This will require you to download a system image.
1.  Boot up an emulator using the AVD manager.
1.  Run the server from Section 1
1.  Build and install the app using mobile-install: `bazel
    mobile-install :android-client`
1.  Use host=10.0.2.2 and port=50051 when the app boots in the emulator



https://goo.gl/forms/uMpvA4RpxPqHN0Fs2

