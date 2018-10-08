load("@io_grpc_grpc_java//:java_grpc_library.bzl", "java_grpc_library")
load("@io_bazel_rules_go//proto:def.bzl", "go_proto_library")

proto_library(
    name = "greeter_proto",
    srcs = ["greeter.proto"],
)

java_proto_library(
    name = "greeter_java_proto",
    visibility = ["//visibility:public"],
    deps = [":greeter_proto"],
)

java_grpc_library(
    name = "greeter_java_grpc",
    srcs = [":greeter_proto"],
    visibility = ["//visibility:public"],
    deps = [":greeter_java_proto"],
)

java_lite_proto_library(
    name = "greeter_java_proto_lite",
    visibility = ["//visibility:public"],
    deps = [":greeter_proto"],
)

java_grpc_library(
    name = "greeter_java_grpc_lite",
    srcs = [":greeter_proto"],
    flavor = "lite",
    visibility = ["//visibility:public"],
    deps = [":greeter_java_proto_lite"],
)

go_proto_library(
    name = "greeter_go_proto",
    compilers = ["@io_bazel_rules_go//proto:go_grpc"],
    # TODO(dannark): change to "github.com/dkelmer/bootcamp/proto/greeter" when moved
    importpath = "bootcamp/proto/greeter",
    proto = ":greeter_proto",
    visibility = ["//visibility:public"],
)
