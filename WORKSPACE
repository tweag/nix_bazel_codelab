workspace(name = "bootcamp")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# BEGIN: Nix dependencies
http_archive(
    name = "io_tweag_rules_nixpkgs",
    sha256 = "aff13f49b37678b4fae1a80710b21478a89d27615a22990a94a99244e4702061",
    strip_prefix = "rules_nixpkgs-74c40cf36e9a79bafc59e745c3d1e49ec3098b23",
    urls = ["https://github.com/tweag/rules_nixpkgs/archive/74c40cf36e9a79bafc59e745c3d1e49ec3098b23.tar.gz"],
)

load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")

rules_nixpkgs_dependencies()

load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_cc_configure", "nixpkgs_java_configure", "nixpkgs_local_repository", "nixpkgs_package")

nixpkgs_local_repository(
    name = "nixpkgs",
    nix_file = "//nix/nixpkgs:default.nix",
)
# END: Nix dependencies

nixpkgs_java_configure(
    attribute_path = "jdk11.home",
    repository = "@nixpkgs",
)

http_archive(
    name = "rules_java",
    sha256 = "34b41ec683e67253043ab1a3d1e8b7c61e4e8edefbcad485381328c934d072fe",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_java/releases/download/4.0.0/rules_java-4.0.0.tar.gz",
        "https://github.com/bazelbuild/rules_java/releases/download/4.0.0/rules_java-4.0.0.tar.gz",
    ],
)

load("@rules_java//java:repositories.bzl", "rules_java_dependencies", "rules_java_toolchains")

rules_java_dependencies()

rules_java_toolchains()
# END: Java dependencies

nixpkgs_cc_configure(
    name = "nixpkgs_config_cc",
    repository = "@nixpkgs",
)

http_archive(
    name = "rules_cc",
    sha256 = "4dccbfd22c0def164c8f47458bd50e0c7148f3d92002cdb459c2a96a68498241",
    urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.1/rules_cc-0.0.1.tar.gz"],
)

load("@rules_cc//cc:repositories.bzl", "rules_cc_dependencies", "rules_cc_toolchains")

rules_cc_dependencies()

rules_cc_toolchains()
# END: CC dependencies

# BEGIN: Protobuf dependencies
http_archive(
    name = "rules_proto",
    # !! uncomment the following two lines if you're using NixOS !!
    #patch_args = ["-p1"],
    #patches = ["@//:patches/rules_proto/nixos.patch"],
    sha256 = "66bfdf8782796239d3875d37e7de19b1d94301e8972b3cbd2446b332429b4df1",
    strip_prefix = "rules_proto-4.0.0",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/refs/tags/4.0.0.tar.gz",
        "https://github.com/bazelbuild/rules_proto/archive/refs/tags/4.0.0.tar.gz",
    ],
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()
# END: Protobuf dependencies

# BEGIN: gRPC dependencies
http_archive(
    name = "io_grpc_grpc_java",
    sha256 = "62faefec4c211709416427ce071f66c901b449fbc471ecb03fbf71d0675db4a3",
    strip_prefix = "grpc-java-1.29.0",
    urls = [
        "https://mirror.bazel.build/github.com/grpc/grpc-java/archive/v1.29.0.tar.gz",
        "https://github.com/grpc/grpc-java/archive/v1.29.0.tar.gz",
    ],
)

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")

grpc_java_repositories()
# END: gRPC dependencies

# BEGIN: Go dependencies
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "2b1641428dff9018f9e85c0384f03ec6c10660d935b750e3fa1492a281a53b0f",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

load("@io_tweag_rules_nixpkgs//nixpkgs:toolchains/go.bzl", "nixpkgs_go_configure")

nixpkgs_go_configure(
    repository = "@nixpkgs",
    sdk_name = "nixpkgs_go_sdk",
)

go_register_toolchains(version = "1.16.9")

http_archive(
    name = "bazel_gazelle",
    sha256 = "de69a09dc70417580aabf20a28619bb3ef60d038470c7cf8442fafcf627c21cb",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("//:deps.bzl", "go_dependencies")

# gazelle:repository_macro deps.bzl%go_dependencies
go_dependencies()

gazelle_dependencies(go_sdk = "nixpkgs_go_sdk")
# END: Go dependencies

# BEGIN: Typescript dependencies
http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "cfc289523cf1594598215901154a6c2515e8bf3671fd708264a6f6aefe02bf39",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/4.4.6/rules_nodejs-4.4.6.tar.gz"],
)

nixpkgs_package(
    name = "nix_node",
    build_file_content = 'exports_files(glob(["nix_node/bin/**"]))',
    nix_file_content = 'with import <nixpkgs> {}; linkFarm "nodejs" [ { name = "nix_node"; path = nodejs-10_x; }]',
    repository = "@nixpkgs",
)

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories", "yarn_install")

node_repositories(
    package_json = ["//typescript:package.json"],
    vendored_node = "@nix_node",
)

yarn_install(
    name = "npm",
    package_json = "//typescript:package.json",
    symlink_node_modules = False,
    yarn_lock = "//typescript:yarn.lock",
)

load("@npm//@bazel/labs:package.bzl", "npm_bazel_labs_dependencies")

npm_bazel_labs_dependencies()

http_archive(
    name = "io_bazel_rules_webtesting",
    sha256 = "e9abb7658b6a129740c0b3ef6f5a2370864e102a5ba5ffca2cea565829ed825a",
    urls = ["https://github.com/bazelbuild/rules_webtesting/releases/download/0.3.5/rules_webtesting.tar.gz"],
)

load("@io_bazel_rules_webtesting//web:repositories.bzl", "web_test_repositories")

web_test_repositories()
# END: Typescript dependencies
