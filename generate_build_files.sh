#!/bin/sh
# This file is used for Bazel CI to write the BUILD files for the project.

# You can use it to see the final solutions but note that it will delete your existing
# BUILD files if you started working.


# generate Go BUILD file

cat > go/cmd/server/BUILD <<EOF
load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

go_binary(
    name = "go-server",
    srcs = ["server.go"],
    deps = [
        "//proto/logger:logger_go_proto",
        "@com_github_golang_protobuf//jsonpb:go_default_library_gen",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_google_grpc//reflection:go_default_library",
    ],
    visibility = ["//visibility:public"]
)
EOF


# generate java BUILD file
cat > java/src/main/java/bazel/bootcamp/BUILD <<EOF
load("@rules_java//java:defs.bzl", "java_binary", "java_library", "java_test")

java_binary(
    name = "HelloBazelBootcamp",
    srcs = ["HelloBazelBootcamp.java"],
)

java_library(
    name = "JavaLoggingClientLibrary",
    srcs = ["JavaLoggingClientLibrary.java"],
    deps = [
        "//proto/logger:logger_java_proto",
        "//proto/logger:logger_java_grpc",
        "@io_grpc_grpc_java//core",
        "@io_grpc_grpc_java//netty",
    ]
)

java_binary(
    name = "JavaLoggingClient",
    srcs = ["JavaLoggingClient.java"],
    deps = [":JavaLoggingClientLibrary"],
    visibility = ["//visibility:public"]
)

java_test(
    name = "JavaLoggingClientLibraryTest",
    srcs = ["JavaLoggingClientLibraryTest.java"],
    deps = [":JavaLoggingClientLibrary"]
)

java_test(
    name = "JavaLoggingClientTest",
    srcs = ["JavaLoggingClientTest.java"],
    deps = [":JavaLoggingClient"]
)
EOF


# generate proto BUILD file
cat > proto/logger/BUILD <<EOF
load("@io_bazel_rules_go//proto:def.bzl", "go_proto_library")
load("@io_grpc_grpc_java//:java_grpc_library.bzl", "java_grpc_library")
load("@npm_bazel_typescript//:index.bzl", "ts_proto_library")
load("@rules_java//java:defs.bzl", "java_proto_library")
load("@rules_proto//proto:defs.bzl", "proto_library")

package(default_visibility = ["//visibility:public"])

proto_library(
    name = "logger_proto",
    srcs = ["logger.proto"]
)

go_proto_library(
    name = "logger_go_proto",
    proto = ":logger_proto",
    compilers = ["@io_bazel_rules_go//proto:go_grpc"],
    importpath = "bootcamp/proto/logger"
)

java_proto_library(
    name = "logger_java_proto",
    deps = [":logger_proto"]
)

java_grpc_library(
    name = "logger_java_grpc",
    srcs = [":logger_proto"],
    deps = [":logger_java_proto"],
)

ts_proto_library(
    name = "logger_ts_proto",
    deps = [":logger_proto"]
)
EOF


# write shell test
cat > tests/BUILD <<EOF
sh_test(
    name = "integration_test",
    srcs = ["integrationtest.sh"],
    data = [
        "//go/cmd/server:go-server",
        "//java/src/main/java/bazel/bootcamp:JavaLoggingClient",
    ],
    tags = ["exclusive"]
)
EOF


cat > typescript/BUILD <<EOF
load("@npm_bazel_typescript//:index.bzl", "ts_library", "ts_devserver")

ts_devserver(
    name = "devserver",
    bootstrap = ["@npm_bazel_typescript//:protobufjs_bootstrap_scripts"],
    entry_module = "bootcamp/typescript/app",
    port = 8088,
    deps = [":app"],
)

ts_library(
    name = "app",
    srcs = ["app.ts"],
    deps = [
        "//proto/logger:logger_ts_proto",
    ],
)

exports_files(["tsconfig.json"])
EOF

# write WORKSPACE file
./generate_workspace.sh
