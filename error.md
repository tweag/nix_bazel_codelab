```ShellSession
[nix-shell:~/tweag/nix_bazel_codelab]$ bazel build //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp --toolchain_resolution_debug='@@bazel_tools//tools/jdk:runtime_toolchain_type'
WARNING: Build option --extra_toolchains has changed, discarding analysis cache (this can be expensive, see https://bazel.build/advanced/performance/iteration-speed).
INFO: ToolchainResolution: Performing resolution of @@bazel_tools//tools/jdk:runtime_toolchain_type for target platform @@rules_nixpkgs_core~0.11.1//platforms:host
      ToolchainResolution:   Toolchain @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime is compatible with target plaform, searching for execution platforms:
      ToolchainResolution:     Compatible execution platform @@rules_nixpkgs_core~0.11.1//platforms:host
      ToolchainResolution:   All execution platforms have been assigned a @@bazel_tools//tools/jdk:runtime_toolchain_type toolchain, stopping
      ToolchainResolution: Recap of selected @@bazel_tools//tools/jdk:runtime_toolchain_type toolchains for target platform @@rules_nixpkgs_core~0.11.1//platforms:host:
      ToolchainResolution:   Selected @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime to run on execution platform @@rules_nixpkgs_core~0.11.1//platforms:host
INFO: ToolchainResolution: Target platform @@rules_nixpkgs_core~0.11.1//platforms:host: Selected execution platform @@rules_nixpkgs_core~0.11.1//platforms:host, type @@bazel_tools//tools/jdk:runtime_toolchain_type -> toolchain @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime
ERROR: /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/rules_java~7.5.0~toolchains~local_jdk/BUILD.bazel:2:10: in fail_rule rule @@rules_java~7.5.0~toolchains~local_jdk//:jdk: 
Traceback (most recent call last):
        File "/home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/rules_java~7.5.0/toolchains/fail_rule.bzl", line 19, column 13, in _fail_rule_impl
                fail("%s %s" % (ctx.attr.header, ctx.attr.message))
Error in fail: Auto-Configuration Error: Cannot find Java binary bin/java in /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/rules_java~7.5.0~toolchains~local_jdk/nosystemjdk; either correct your JAVA_HOME, PATH or specify Java from remote repository (e.g. --java_runtime_version=remotejdk_11)
ERROR: /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/external/rules_java~7.5.0~toolchains~local_jdk/BUILD.bazel:2:10: Analysis of target '@@rules_java~7.5.0~toolchains~local_jdk//:jdk' failed
ERROR: Analysis of target '//java/src/main/java/bazel/bootcamp:HelloBazelBootcamp' failed; build aborted: Analysis failed
INFO: Elapsed time: 0.204s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
ERROR: Build did NOT complete successfully

[nix-shell:~/tweag/nix_bazel_codelab]$ bazel --nosystem_rc build //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp --toolchain_resolution_debug='@@bazel_tools//tools/jdk:runtime_toolchain_type'
WARNING: The following rc files are no longer being read, please transfer their contents or import their path into one of the standard rc files:
/nix/store/cxjc7filv802s5ws35hga85wy5pbxz3l-bazel-rc
WARNING: Build option --toolchain_resolution_debug has changed, discarding analysis cache (this can be expensive, see https://bazel.build/advanced/performance/iteration-speed).
INFO: ToolchainResolution: Performing resolution of @@bazel_tools//tools/jdk:runtime_toolchain_type for target platform @@rules_nixpkgs_core~0.11.1//platforms:host
      ToolchainResolution:   Toolchain @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime is compatible with target plaform, searching for execution platforms:
      ToolchainResolution:     Compatible execution platform @@rules_nixpkgs_core~0.11.1//platforms:host
      ToolchainResolution:   All execution platforms have been assigned a @@bazel_tools//tools/jdk:runtime_toolchain_type toolchain, stopping
      ToolchainResolution: Recap of selected @@bazel_tools//tools/jdk:runtime_toolchain_type toolchains for target platform @@rules_nixpkgs_core~0.11.1//platforms:host:
      ToolchainResolution:   Selected @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime to run on execution platform @@rules_nixpkgs_core~0.11.1//platforms:host
INFO: ToolchainResolution: Target platform @@rules_nixpkgs_core~0.11.1//platforms:host: Selected execution platform @@rules_nixpkgs_core~0.11.1//platforms:host, type @@bazel_tools//tools/jdk:runtime_toolchain_type -> toolchain @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime
INFO: ToolchainResolution: Performing resolution of @@bazel_tools//tools/jdk:runtime_toolchain_type for target platform @@rules_nixpkgs_core~0.11.1//platforms:host
      ToolchainResolution:   Toolchain @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime is compatible with target plaform, searching for execution platforms:
      ToolchainResolution:     Compatible execution platform @@rules_nixpkgs_core~0.11.1//platforms:host
      ToolchainResolution:   All execution platforms have been assigned a @@bazel_tools//tools/jdk:runtime_toolchain_type toolchain, stopping
      ToolchainResolution: Recap of selected @@bazel_tools//tools/jdk:runtime_toolchain_type toolchains for target platform @@rules_nixpkgs_core~0.11.1//platforms:host:
      ToolchainResolution:   Selected @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime to run on execution platform @@rules_nixpkgs_core~0.11.1//platforms:host
INFO: ToolchainResolution: Target platform @@rules_nixpkgs_core~0.11.1//platforms:host: Selected execution platform @@rules_nixpkgs_core~0.11.1//platforms:host, type @@bazel_tools//tools/jdk:runtime_toolchain_type -> toolchain @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime
INFO: ToolchainResolution: Performing resolution of @@bazel_tools//tools/jdk:runtime_toolchain_type for target platform @@rules_nixpkgs_core~0.11.1//platforms:host
      ToolchainResolution:   Rejected toolchain @@_main~non_module_dependencies~nixpkgs_java_runtime//:runtime; mismatching config settings: nixpkgs_java_name_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~local_jdk//:jdk; mismatching config settings: localjdk_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk11_linux//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk11_linux_aarch64//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk11_linux_ppc64le//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk11_linux_s390x//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk11_macos//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk11_macos_aarch64//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk11_win//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk11_win_arm64//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk17_linux//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk17_linux_aarch64//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk17_linux_ppc64le//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk17_linux_s390x//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk17_macos//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk17_macos_aarch64//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk17_win//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Rejected toolchain @@rules_java~7.5.0~toolchains~remotejdk17_win_arm64//:jdk; mismatching config settings: prefix_version_setting
      ToolchainResolution:   Toolchain @@rules_java~7.5.0~toolchains~remotejdk21_linux//:jdk is compatible with target plaform, searching for execution platforms:
      ToolchainResolution:     Compatible execution platform @@rules_nixpkgs_core~0.11.1//platforms:host
      ToolchainResolution:   All execution platforms have been assigned a @@bazel_tools//tools/jdk:runtime_toolchain_type toolchain, stopping
      ToolchainResolution: Recap of selected @@bazel_tools//tools/jdk:runtime_toolchain_type toolchains for target platform @@rules_nixpkgs_core~0.11.1//platforms:host:
      ToolchainResolution:   Selected @@rules_java~7.5.0~toolchains~remotejdk21_linux//:jdk to run on execution platform @@rules_nixpkgs_core~0.11.1//platforms:host
INFO: ToolchainResolution: Target platform @@rules_nixpkgs_core~0.11.1//platforms:host: Selected execution platform @@rules_nixpkgs_core~0.11.1//platforms:host, type @@bazel_tools//tools/jdk:runtime_toolchain_type -> toolchain @@rules_java~7.5.0~toolchains~remotejdk21_linux//:jdk
INFO: Analyzed target //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp (0 packages loaded, 1136 targets configured).
ERROR: /home/rednaz/tweag/nix_bazel_codelab/java/src/main/java/bazel/bootcamp/BUILD.bazel:1:12: Building java/src/main/java/bazel/bootcamp/HelloBazelBootcamp.jar (1 source file) failed: IOException while preparing the execution environment of a worker:

---8<---8<--- Exception details ---8<---8<---
java.io.IOException: Cannot run program "/home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/execroot/_main/external/rules_java~7.5.0~toolchains~remotejdk21_linux/bin/java" (in directory "/home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/execroot/_main"): error=2, No such file or directory
        at java.base/java.lang.ProcessBuilder.start(ProcessBuilder.java:1143)
        at java.base/java.lang.ProcessBuilder.start(ProcessBuilder.java:1073)
        at com.google.devtools.build.lib.shell.JavaSubprocessFactory.start(JavaSubprocessFactory.java:152)
        at com.google.devtools.build.lib.shell.JavaSubprocessFactory.create(JavaSubprocessFactory.java:182)
        at com.google.devtools.build.lib.shell.SubprocessBuilder.start(SubprocessBuilder.java:251)
        at com.google.devtools.build.lib.worker.WorkerMultiplexer.createProcess(WorkerMultiplexer.java:197)
        at com.google.devtools.build.lib.worker.WorkerProxy.prepareExecution(WorkerProxy.java:63)
        at com.google.devtools.build.lib.worker.WorkerSpawnRunner.executeRequest(WorkerSpawnRunner.java:529)
        at com.google.devtools.build.lib.worker.WorkerSpawnRunner.execInWorker(WorkerSpawnRunner.java:422)
        at com.google.devtools.build.lib.worker.WorkerSpawnRunner.exec(WorkerSpawnRunner.java:206)
        at com.google.devtools.build.lib.exec.AbstractSpawnStrategy.exec(AbstractSpawnStrategy.java:159)
        at com.google.devtools.build.lib.exec.AbstractSpawnStrategy.exec(AbstractSpawnStrategy.java:119)
        at com.google.devtools.build.lib.exec.SpawnStrategyResolver.exec(SpawnStrategyResolver.java:45)
        at com.google.devtools.build.lib.rules.java.JavaCompileAction.execute(JavaCompileAction.java:419)
        at com.google.devtools.build.lib.skyframe.SkyframeActionExecutor$ActionRunner.executeAction(SkyframeActionExecutor.java:1148)
        at com.google.devtools.build.lib.skyframe.SkyframeActionExecutor$ActionRunner.run(SkyframeActionExecutor.java:1065)
        at com.google.devtools.build.lib.skyframe.ActionExecutionState.runStateMachine(ActionExecutionState.java:165)
        at com.google.devtools.build.lib.skyframe.ActionExecutionState.getResultOrDependOnFuture(ActionExecutionState.java:94)
        at com.google.devtools.build.lib.skyframe.SkyframeActionExecutor.executeAction(SkyframeActionExecutor.java:562)
        at com.google.devtools.build.lib.skyframe.ActionExecutionFunction.checkCacheAndExecuteIfNeeded(ActionExecutionFunction.java:859)
        at com.google.devtools.build.lib.skyframe.ActionExecutionFunction.computeInternal(ActionExecutionFunction.java:333)
        at com.google.devtools.build.lib.skyframe.ActionExecutionFunction.compute(ActionExecutionFunction.java:171)
        at com.google.devtools.build.skyframe.AbstractParallelEvaluator$Evaluate.run(AbstractParallelEvaluator.java:461)
        at com.google.devtools.build.lib.concurrent.AbstractQueueVisitor$WrappedRunnable.run(AbstractQueueVisitor.java:414)
        at java.base/java.util.concurrent.ForkJoinTask$RunnableExecuteAction.exec(ForkJoinTask.java:1395)
        at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:373)
        at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1182)
        at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1655)
        at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1622)
        at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:165)
Caused by: java.io.IOException: error=2, No such file or directory
        at java.base/java.lang.ProcessImpl.forkAndExec(Native Method)
        at java.base/java.lang.ProcessImpl.<init>(ProcessImpl.java:314)
        at java.base/java.lang.ProcessImpl.start(ProcessImpl.java:244)
        at java.base/java.lang.ProcessBuilder.start(ProcessBuilder.java:1110)
        ... 29 more
---8<---8<--- End of exception details ---8<---8<---

---8<---8<--- Start of log, file at /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/bazel-workers/multiplex-worker-2-Javac.log ---8<---8<---
(empty)
---8<---8<--- End of log ---8<---8<---
Target //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 0.318s, Critical Path: 0.01s
INFO: 2 processes: 2 internal.
ERROR: Build did NOT complete successfully
```
