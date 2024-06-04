"""
This module contains the non-module dependencies used by this codelab.
"""

load("@rules_nixpkgs_go//:go.bzl", "nixpkgs_go_configure")
load("@rules_nixpkgs_java//:java.bzl", "nixpkgs_java_configure")

def _non_module_dependencies_impl(_ctx):
    nixpkgs_java_configure(
        name = "nixpkgs_java_runtime",
        attribute_path = "openjdk19.home",
        repository = Label("@nixpkgs"),
        toolchain = True,
        toolchain_name = "nixpkgs_java",
        toolchain_version = "19",
        register = False,
    )
    nixpkgs_go_configure(
        sdk_name = "go_sdk",
        repository = Label("@nixpkgs"),
        register = False,
    )

non_module_dependencies = module_extension(
    implementation = _non_module_dependencies_impl,
)
