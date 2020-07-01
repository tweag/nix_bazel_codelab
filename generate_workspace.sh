# This file is used for Bazel CI to write the WORKSPACE file for the project.

# You can use it to see the final solutions but note that it will delete your existing
# WORKSPACE files if you started working.

# write WORKSPACE file
cat > WORKSPACE <<EOF
workspace(name = "bootcamp")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# BEGIN: Java dependencies
http_archive(
    name = "rules_java",
    sha256 = "1969a89e8da396eb7754fd0247b7df39b6df433c3dcca0095b4ba30a5409cc9d",
    strip_prefix = "rules_java-32ddd6c4f0ad38a54169d049ec05febc393b58fc",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_java/archive/32ddd6c4f0ad38a54169d049ec05febc393b58fc.tar.gz",
        "https://github.com/bazelbuild/rules_java/archive/32ddd6c4f0ad38a54169d049ec05febc393b58fc.tar.gz",
    ],
)

load("@rules_java//java:repositories.bzl", "rules_java_dependencies", "rules_java_toolchains")
rules_java_dependencies()
rules_java_toolchains()
# END: Java dependencies


# BEGIN: Protobuf dependencies
http_archive(
    name = "rules_proto",
    sha256 = "4d421d51f9ecfe9bf96ab23b55c6f2b809cbaf0eea24952683e397decfbd0dd0",
    strip_prefix = "rules_proto-f6b8d89b90a7956f6782a4a3609b2f0eee3ce965",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/f6b8d89b90a7956f6782a4a3609b2f0eee3ce965.tar.gz",
        "https://github.com/bazelbuild/rules_proto/archive/f6b8d89b90a7956f6782a4a3609b2f0eee3ce965.tar.gz",
    ],
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()
# END: Protobuf dependencies


# BEGIN: gRPC dependencies
http_archive(
    name = "io_grpc_grpc_java",
    urls = [
        "https://mirror.bazel.build/github.com/grpc/grpc-java/archive/v1.29.0.tar.gz",
        "https://github.com/grpc/grpc-java/archive/v1.29.0.tar.gz",
    ],
    sha256 = "62faefec4c211709416427ce071f66c901b449fbc471ecb03fbf71d0675db4a3",
    strip_prefix = "grpc-java-1.29.0",
)

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")
grpc_java_repositories()
# END: gRPC dependencies


# BEGIN: Go dependencies
http_archive(
    name = "io_bazel_rules_go",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/rules_go/releases/download/v0.21.2/rules_go-v0.21.2.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.21.2/rules_go-v0.21.2.tar.gz",
    ],
    sha256 = "f99a9d76e972e0c8f935b2fe6d0d9d778f67c760c6d2400e23fc2e469016e2bd",
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
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
# END: Go dependencies


# BEGIN: Typescript dependencies
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
# END: Typescript dependencies
EOF
