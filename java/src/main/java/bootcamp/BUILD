java_library(
    name = "hello-world-server-lib",
    srcs = ["HelloWorldServer.java"],
    deps = [
        "//proto/greeter:greeter_java_grpc",
        "//proto/greeter:greeter_java_proto",
        "@io_grpc_grpc_java//core",
        "@io_grpc_grpc_java//netty",
        "@io_grpc_grpc_java//stub",
    ],
)

java_library(
    name = "hello-world-client-lib",
    srcs = ["HelloWorldClient.java"],
    deps = [
        "//proto/greeter:greeter_java_grpc",
        "//proto/greeter:greeter_java_proto",
        "@io_grpc_grpc_java//core",
        "@io_grpc_grpc_java//netty",
    ],
)

java_library(
    name = "hello-world-lib",
    srcs = glob(
        ["*.java"],
    ),
    deps = [
        "//proto/greeter:greeter_java_grpc",
        "//proto/greeter:greeter_java_proto",
        "//proto/logger:logger_java_grpc",
        "//proto/logger:logger_java_proto",
        "@io_grpc_grpc_java//core",
        "@io_grpc_grpc_java//netty",
        "@io_grpc_grpc_java//stub",
    ],
)

java_binary(
    name = "hello-world-server",
    testonly = 1,
    main_class = "bazel.bootcamp.HelloWorldServer",
    runtime_deps = [
        ":hello-world-server-lib",
    ],
)

java_binary(
    name = "hello-world-client",
    testonly = 1,
    main_class = "bazel.bootcamp.HelloWorldClient",
    runtime_deps = [
        ":hello-world-client-lib",
    ],
)

java_binary(
    name = "HelloBazelBootcamp",
    srcs = ["HelloBazelBootcamp.java"],
    main_class = "bazel.bootcamp.HelloBazelBootcamp",
)

java_library(
    name = "java-logging-client-lib",
    srcs = ["JavaLoggingLibrary.java"],
    deps = [
        "//proto/logger:logger_java_grpc",
        "//proto/logger:logger_java_proto",
        "@io_grpc_grpc_java//core",
        "@io_grpc_grpc_java//netty",
    ],
)

java_binary(
    name = "JavaLoggingClient",
    srcs = ["JavaLoggingClient.java"],
    main_class = "bazel.bootcamp.JavaLoggingClient",
    visibility = ["//tests:__subpackages__"],
    deps = [":java-logging-client-lib"],
)

java_test(
    name = "java-logging-client-library-test",
    size = "small",
    srcs = ["JavaLoggingClientLibraryTest.java"],
    test_class = "bazel.bootcamp.JavaLoggingClientLibraryTest",
    deps = [
        ":java-logging-client-lib",
    ],
)

java_test(
    name = "java-logging-client-test",
    size = "small",
    srcs = ["JavaLoggingClientTest.java"],
    test_class = "bazel.bootcamp.JavaLoggingClientTest",
    deps = [":JavaLoggingClient"],
)
