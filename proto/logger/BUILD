package(default_visibility = ["//visibility:public"])

load("@io_grpc_grpc_java//:java_grpc_library.bzl", "java_grpc_library")
load("@io_bazel_rules_go//proto:def.bzl", "go_proto_library")
load("@npm_bazel_typescript//:index.bzl", "ts_proto_library")

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