load("@npm_bazel_typescript//:index.bzl", "ts_devserver", "ts_library")

ts_devserver(
    name = "devserver",
    bootstrap = ["@npm_bazel_typescript//:protobufjs_bootstrap_scripts"],
    entry_module = "bootcamp/typescript/app",
    port = 8088,
    deps = [":app"],
)

ts_library(
    name = "app",
    srcs = ["app.ts"],
    deps = [
        "//proto/logger:logger_ts_proto",
    ],
)

exports_files(["tsconfig.json"])
