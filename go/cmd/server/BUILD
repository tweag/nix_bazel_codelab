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