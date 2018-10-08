package(default_visibility = ["//visibility:public"])

load("@io_grpc_grpc_java//:java_grpc_library.bzl", "java_grpc_library")
load("@io_bazel_rules_go//proto:def.bzl", "go_proto_library")
load("@build_bazel_rules_typescript//:defs.bzl", "ts_proto_library")

proto_library(
    name = "logger_proto",
    srcs = ["logger.proto"],
)

java_proto_library(
    name = "logger_java_proto",
    deps = [":logger_proto"],
)

java_grpc_library(
    name = "logger_java_grpc",
    srcs = [":logger_proto"],
    deps = [":logger_java_proto"],
)

java_lite_proto_library(
    name = "logger_java_proto_lite",
    deps = [":logger_proto"],
)

java_grpc_library(
    name = "logger_java_grpc_lite",
    srcs = [":logger_proto"],
    flavor = "lite",
    deps = [":logger_java_proto_lite"],
)

go_proto_library(
    name = "logger_go_proto",
    compilers = ["@io_bazel_rules_go//proto:go_grpc"],
    # TODO(dannark): change to "github.com/dkelmer/bootcamp/proto/logger" when moved
    importpath = "bootcamp/proto/logger",
    proto = ":logger_proto",
)

ts_proto_library(
    name = "logger_ts_proto",
    deps = [":logger_proto"],
)
