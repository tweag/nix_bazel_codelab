workspace(name = "bootcamp")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# grpc dependencies
git_repository(
    name = "io_grpc_grpc_java",
    commit = "337b78cd34344d8b06eeddea21d4ff2140c09144",
    remote = "https://github.com/grpc/grpc-java.git",
)

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")

grpc_java_repositories()

# go dependencies
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "97cf62bdef33519412167fd1e4b0810a318a7c234f5f8dc4f53e2da86241c492",
    urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.15.3/rules_go-0.15.3.tar.gz"],
)

load("@io_bazel_rules_go//go:def.bzl", "go_rules_dependencies", "go_register_toolchains")

go_rules_dependencies()

go_register_toolchains()

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
