# Bazel Codelab

### [Informational slides](https://docs.google.com/presentation/d/1MNBUCde6vgs5kk--hDYXp3JS-whD3AnLRZOdelGQZ5s/edit?usp=sharing)

## Section 1: Hello, Bazel!

1.  Edit: `java/src/main/java/bazel/bootcamp/BUILD`
1.  Add a `java_binary` target for the `HelloBazelBootcamp.java` file
    - Documentation: https://docs.bazel.build/versions/master/be/java.html#java_binary
1.  Run the binary using `bazel run //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp`

## Section 2: Go server
1.  Edit the `BUILD` file for `logger.proto`
    - Documentation: https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library
    - Documentation: https://github.com/bazelbuild/rules_go/blob/master/proto/core.rst#example-grpc
    <details> <summary>Hint</summary>Check out the <code>compilers</code> attribute for <code>go_proto_library</code> in the grpc example</details>
    <details> <summary>Hint</summary>Go libraries each declare the import path at which they would like to be imported by other go files. <code>server.go</code> imports the proto file at <code>bootcamp/proto/logger</code> so the <code>importpath</code> attribute of <code>go_proto_library</code> should match that.</details>
    
1.  Edit the `BUILD` file for `server.go`
    - Documentation: https://github.com/bazelbuild/rules_go/blob/master/go/core.rst#go_binary    
1.  Run the go binary using `bazel run`
1.  Go to http://localhost:8081 to see results (there won't be any logs yet)

## Section 3: Java client

1.  Edit the `BUILD` file for `logger.proto`
    - Documentation: https://docs.bazel.build/versions/master/be/java.html#java_proto_library
    - Documentation: https://grpc.io/docs/reference/java/generated-code.html (look towards the
      bottom of the page for Bazel related documentation)
1.  Edit the `BUILD` file for `JavaLoggingClientLibrary.java`
    - Documentation: https://docs.bazel.build/versions/master/be/java.html#java_library
1.  Edit the `BUILD` file for `JavaLoggingClient.java`
    - Documentation: https://docs.bazel.build/versions/master/be/java.html#java_binary
1.  `bazel run` the Java binary you wrote
1.  `bazel run` the Go binary from Section 2
1.  Send messages from the client to the server and view them on http://localhost:8081

## Section 4: Java client unit tests
1.  Edit the `BUILD` file for `JavaLoggingClientLibraryTest.java`
    <details> <summary>Hint</summary>Names matter for tests. The <code>java_test</code> for this file should be named <code>JavaLoggingClientLibraryTest</code></details>
1.  Edit the `BUILD` file for `JavaLoggingClientTest.java`
    - Documentation: https://docs.bazel.build/versions/master/be/java.html#java_test
1.  Run the tests using `bazel test`

## Section 5: Typescript web frontend
1.  Edit the `WORKSPACE` file to add the typescript external dependencies following steps
    from here: https://github.com/alexeagle/ts-from-bazel/blob/master/README.md. Note that
    those instructions assume that you are starting with an empty project. So you will need
    to add the listed dependencies to the WORKSPACE file, but you don't need to run the
    commands to generate the files like `yarn.lock` or `package.json`. Check the existing
    project to see what is present. 
1.  Edit the `BUILD` file for `app.ts`
    - Documentation: https://github.com/bazelbuild/rules_typescript#usage
1.  Run the webserver using `bazel run`. It will print out a link which you can click on.
    If the link doesn't work, go to http://localhost:8080 instead
1.  Run the Go server and Java client from the previous steps. Send messages from the Java
    client to the Go server and see them appear on the web frontend
    
## Section 6: Integration test
1.  Edit the `BUILD` file for `integrationtest.sh`
    - Documentation: https://docs.bazel.build/versions/master/be/shell.html#sh_test
1.  Run the test using `bazel test` and make sure that it passes
1.  Run the test using `bazel test <target> --runs_per_test=10` and make sure that it passes
    <details> <summary>Hint</summary>You may need to modify the <code>BUILD</code> file again to make this work</details>

## Section 7: Query
1.  https://docs.bazel.build/versions/master/query-how-to.html


