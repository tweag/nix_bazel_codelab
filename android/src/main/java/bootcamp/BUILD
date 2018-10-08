load("@gmaven_rules//:defs.bzl", "gmaven_artifact")

android_library(
    name = "android-client-lib",
    srcs = ["AndroidLoggingClientActivity.java"],
    custom_package = "bazel.bootcamp",
    manifest = "LibraryManifest.xml",
    resource_files = glob(["res/**"]),
    deps = [
        "//proto/logger:logger_java_grpc_lite",
        "//proto/logger:logger_java_proto_lite",
        gmaven_artifact("com.android.support:appcompat-v7:aar:25.0.0"),
        "@io_grpc_grpc_java//core",
        "@io_grpc_grpc_java//netty",
        "@io_grpc_grpc_java//stub",
    ],
)

android_binary(
    name = "android-client",
    manifest = "AndroidManifest.xml",
    multidex = "native",
    deps = [":android-client-lib"],
)

android_library(
    name = "Xandroid-client-lib",
    srcs = ["HelloWorldActivity.java"],
    custom_package = "bazel.bootcamp",
    manifest = "LibraryManifest.xml",
    resource_files = glob(["res/**"]),
    deps = [
        "//proto/greeter:greeter_java_grpc_lite",
        "//proto/greeter:greeter_java_proto_lite",
        gmaven_artifact("com.android.support:appcompat-v7:aar:25.0.0"),
        "@io_grpc_grpc_java//core",
        "@io_grpc_grpc_java//netty",
        "@io_grpc_grpc_java//stub",
    ],
)

android_binary(
    name = "Xandroid-client",
    manifest = "AndroidManifest.xml",
    multidex = "native",
    deps = [":android-client-lib"],
)
