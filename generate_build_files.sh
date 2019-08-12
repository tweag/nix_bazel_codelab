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
http_archive(
    name = "io_grpc_grpc_java",
    urls = [
        "https://github.com/grpc/grpc-java/archive/v1.22.1.tar.gz",
    ],
    sha256 = "6e63bd6f5a82de0b84c802390adb8661013bad9ebf910ad7e1f3f72b5f798832",
    strip_prefix = "grpc-java-1.22.1",
)
load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")
grpc_java_repositories()


# go dependencies
http_archive(
    name = "io_bazel_rules_go",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/rules_go/releases/download/0.19.1/rules_go-0.19.1.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/0.19.1/rules_go-0.19.1.tar.gz",
    ],
    sha256 = "8df59f11fb697743cbb3f26cfb8750395f30471e9eabde0d174c3aebc7a1cd39",
)
load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies", "go_register_toolchains")
go_rules_dependencies()
go_register_toolchains()

http_archive(
    name = "bazel_gazelle",
    urls = [
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/0.18.1/bazel-gazelle-0.18.1.tar.gz",
    ],
    sha256 = "be9296bfd64882e3c08e3283c58fcb461fa6dd3c171764fcc4cf322f60615a9b",
)
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")
gazelle_dependencies()

go_repository(
    name = "org_golang_google_grpc",
    build_file_proto_mode = "disable",
    importpath = "google.golang.org/grpc",
    sum = "h1:J0UbZOIrCAl+fpTOf8YLs4dJo8L/owV4LYVtAXQoPkw=",
    version = "v1.22.0",
)
go_repository(
    name = "org_golang_x_net",
    importpath = "golang.org/x/net",
    sum = "h1:oWX7TPOiFAMXLq8o0ikBYfCJVlRHBcsciT5bXOrH628=",
    version = "v0.0.0-20190311183353-d8887717615a",
)
go_repository(
    name = "org_golang_x_text",
    importpath = "golang.org/x/text",
    sum = "h1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg=",
    version = "v0.3.0",
)

# BEGIN: typescript dependencies
http_archive(
    name = "build_bazel_rules_nodejs",
    urls = [
        "https://github.com/bazelbuild/rules_nodejs/releases/download/0.35.0/rules_nodejs-0.35.0.tar.gz",
    ],
    sha256 = "6625259f9f77ef90d795d20df1d0385d9b3ce63b6619325f702b6358abb4ab33",
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
# END: typescript dependencies
EOF
