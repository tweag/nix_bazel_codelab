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
    urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.18.1/rules_go-0.18.1.tar.gz"],
    sha256 = "77dfd303492f2634de7a660445ee2d3de2960cbd52f97d8c0dffa9362d3ddef9",
)
load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies", "go_register_toolchains")
go_rules_dependencies()
go_register_toolchains()



# typescript dependencies
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "fb87ed5965cef93188af9a7287511639403f4b0da418961ce6defb9dcf658f51",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/0.27.7/rules_nodejs-0.27.7.tar.gz"],
)

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories", "yarn_install")
node_repositories(package_json = ["//typescript:package.json"])
yarn_install(
    name = "npm",
    package_json = "//typescript:package.json",
    yarn_lock = "//typescript:yarn.lock",
)

load("@npm//:install_bazel_dependencies.bzl", "install_bazel_dependencies")
install_bazel_dependencies()

load("@npm_bazel_typescript//:index.bzl", "ts_setup_workspace")
ts_setup_workspace()



# android dependencies -- uncomment these lines if you wish to build the
# android portion of the project
#android_sdk_repository(
#    name = "androidsdk",
#)
#
#GMAVEN_TAG = "20180916-1"
#
#http_archive(
#    name = "gmaven_rules",
#    strip_prefix = "gmaven_rules-%s" % GMAVEN_TAG,
#    url = "https://github.com/bazelbuild/gmaven_rules/archive/%s.tar.gz" % GMAVEN_TAG,
#)
#
#load("@gmaven_rules//:gmaven.bzl", "gmaven_rules")
#
#gmaven_rules()
