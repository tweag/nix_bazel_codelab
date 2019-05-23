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


# write WORKSPACE file 
cat > WORKSPACE <<EOF
workspace(name = "bootcamp")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# grpc dependencies
git_repository(
    name = "io_grpc_grpc_java",
    commit = "a2cda8d15d752624180460d3e7e7d7322da13a2d",
    remote = "https://github.com/grpc/grpc-java.git",
)
load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")
grpc_java_repositories()



# go dependencies
http_archive(
    name = "io_bazel_rules_go",
    urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.18.5/rules_go-0.18.5.tar.gz"],
    sha256 = "a82a352bffae6bee4e95f68a8d80a70e87f42c4741e6a448bec11998fcc82329",
)
load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies", "go_register_toolchains")
go_rules_dependencies()
go_register_toolchains()



# typescript dependencies
http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "73325a155c16bfbde29fb2ffcaf59d9d5a1c13b06ada386d3edd5a9d82bda702",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/0.29.1/rules_nodejs-0.29.1.tar.gz"],
)

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories", "yarn_install")

yarn_install(
    name = "npm",
    package_json = "//typescript:package.json",
    yarn_lock = "//typescript:yarn.lock",
)

load("@npm//:install_bazel_dependencies.bzl", "install_bazel_dependencies")
install_bazel_dependencies()

load("@npm_bazel_typescript//:index.bzl", "ts_setup_workspace")
ts_setup_workspace()
EOF