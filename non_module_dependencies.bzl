load("@rules_nixpkgs_java//:java.bzl", "nixpkgs_java_configure")

def _non_module_dependencies_impl(_ctx):
    nixpkgs_java_configure(
        name = "nixpkgs_java_runtime",
        attribute_path = "openjdk19.home",
        repository = "@nixpkgs",
        toolchain = True,
        toolchain_name = "nixpkgs_java",
        toolchain_version = "19",
        register = False,
    )

non_module_dependencies = module_extension(
    implementation = _non_module_dependencies_impl,
)
