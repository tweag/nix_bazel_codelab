- why can bazel not find `bin/java` in `/nix/store/sp9pjibkin0f5v48m648vfzizlg1pbfp-openjdk-11.0.19+7/lib/openjdk`?
- what is `@@bazel_tools//tools/jdk:toolchain_type`?
  - why does `nixpkgs_java_configure` not assign `@@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime` to it?
  - why is `@@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime` not assigned to it even after [my patch](https://github.com/tweag/rules_nixpkgs/commit/65304dbf53c75bf1539374e1718dba996279ae0a)?

```ShellSession
[nix-shell:~/tweag/nix_bazel_codelab]$ bazel build //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp --toolchain_resolution_debug='@@bazel_tools//tools/jdk'
INFO: ToolchainResolution: Target platform @@rules_nixpkgs_core~0.10.0//platforms:host:
      Selected execution platform @@rules_nixpkgs_core~0.10.0//platforms:host,
      type @@bazel_tools//tools/jdk:toolchain_type -> toolchain @@bazel_tools//tools/jdk:nonprebuilt_toolchain_java11

INFO: ToolchainResolution: Target platform @@rules_nixpkgs_core~0.10.0//platforms:host:
      Selected execution platform @@rules_nixpkgs_core~0.10.0//platforms:host,
      type @@bazel_tools//tools/jdk:runtime_toolchain_type -> toolchain @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime

INFO: ToolchainResolution: Target platform @@rules_nixpkgs_core~0.10.0//platforms:host:
      Selected execution platform @@rules_nixpkgs_core~0.10.0//platforms:host,
      type @@bazel_tools//tools/jdk:bootstrap_runtime_toolchain_type -> toolchain @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime

INFO: ToolchainResolution: Performing resolution of @@bazel_tools//tools/jdk:toolchain_type for target platform @@rules_nixpkgs_core~0.10.0//platforms:host
      ToolchainResolution:   Rejected toolchain @@bazel_tools//tools/jdk:nonprebuilt_toolchain_java10; mismatching config settings: nonprebuilt_toolchain_java10_version_setting
      ToolchainResolution:   Toolchain @@bazel_tools//tools/jdk:nonprebuilt_toolchain_java11 is compatible with target plaform, searching for execution platforms:
      ToolchainResolution:     Compatible execution platform @@rules_nixpkgs_core~0.10.0//platforms:host
      ToolchainResolution:   All execution platforms have been assigned a @@bazel_tools//tools/jdk:toolchain_type toolchain, stopping
      ToolchainResolution: Recap of selected @@bazel_tools//tools/jdk:toolchain_type toolchains for target platform @@rules_nixpkgs_core~0.10.0//platforms:host:
      ToolchainResolution:   Selected @@bazel_tools//tools/jdk:nonprebuilt_toolchain_java11 to run on execution platform @@rules_nixpkgs_core~0.10.0//platforms:host

ERROR: /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/rules_java~7.5.0~toolchains~local_jdk/BUILD.bazel:2:10: in fail_rule rule @@rules_java~7.5.0~toolchains~local_jdk//:jdk: 
Traceback (most recent call last):
        File "/home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/rules_java~7.5.0/toolchains/fail_rule.bzl", line 19, column 13, in _fail_rule_impl
                fail("%s %s" % (ctx.attr.header, ctx.attr.message))
Error in fail: Auto-Configuration Error: Cannot find Java binary bin/java in /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/rules_java~7.5.0~toolchains~local_jdk/nosystemjdk; either correct your JAVA_HOME, PATH or specify Java from remote repository (e.g. --java_runtime_version=remotejdk_11)
ERROR: /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/rules_java~7.5.0~toolchains~local_jdk/BUILD.bazel:2:10: Analysis of target '@@rules_java~7.5.0~toolchains~local_jdk//:jdk' failed
INFO: Repository rules_java~7.5.0~toolchains~remote_java_tools instantiated at:
  <builtin>: in <toplevel>
Repository rule http_archive defined at:
  /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/bazel_tools/tools/build_defs/repo/http.bzl:384:31: in <toplevel>
ERROR: Analysis of target '//java/src/main/java/bazel/bootcamp:HelloBazelBootcamp' failed; build aborted: Analysis failed
INFO: Elapsed time: 0.064s
INFO: 0 processes.
ERROR: Build did NOT complete successfully
Loading: 0 packages loaded
    Fetching repository @@bazel_tools~cc_configure_extension~local_config_cc; starting

[nix-shell:~/tweag/nix_bazel_codelab]$ cat $(bazel info output_base)/external/_main~non_module_dependencies~nixpkgs_java_runtime/BUILD.bazel
cat: /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/_main~non_module_dependencies~nixpkgs_java_runtime/BUILD.bazel: No such file or directory

[nix-shell:~/tweag/nix_bazel_codelab]$ bazel cquery @@_main~non_module_dependencies~nixpkgs_java_runtime//...
WARNING: Build option --toolchain_resolution_debug has changed, discarding analysis cache (this can be expensive, see https://bazel.build/advanced/performance/iteration-speed).
INFO: Analyzed 2 targets (6 packages loaded, 10 targets configured).
INFO: Found 2 targets...
@@_main~non_module_dependencies~nixpkgs_java_runtime//bazel-support/nix-out-link:runtime (83a2520)
@@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime (83a2520)
INFO: Elapsed time: 0.153s, Critical Path: 0.00s
INFO: 0 processes.
INFO: Build completed successfully, 0 total actions

[nix-shell:~/tweag/nix_bazel_codelab]$ cat $(bazel info output_base)/external/_main~non_module_dependencies~nixpkgs_java_runtime/BUILD.bazel
load("@rules_java//java:defs.bzl", "java_runtime")
java_runtime(
    name = "runtime",
    java_home = r"/nix/store/sp9pjibkin0f5v48m648vfzizlg1pbfp-openjdk-11.0.19+7/lib/openjdk",
    visibility = ["//visibility:public"],
)

```
