```ShellSession
[nix-shell:~/tweag/nix_bazel_codelab]$ bazel build //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp 
INFO: Analyzed target //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp (82 packages loaded, 997 targets configured).
ERROR: /home/rednaz/tweag/nix_bazel_codelab/java/src/main/java/bazel/bootcamp/BUILD.bazel:1:12: Building java/src/main/java/bazel/bootcamp/HelloBazelBootcamp.jar (1 source file) failed: Worker process did not return a WorkResponse:

---8<---8<--- Start of log, file at /home/rednaz/.cache/bazel/_bazel_rednaz/4416c53fc376f6850591c05e606de763/bazel-workers/multiplex-worker-1-Javac.log ---8<---8<---
Error thrown by worker thread, shutting down worker.
java.lang.NoSuchMethodError: 'java.lang.Iterable com.google.devtools.build.buildjar.javac.BlazeJavacMain$ClassloaderMaskingFileManager.getJavaFileObjectsFromPaths(java.util.Collection)'
        at com.google.devtools.build.buildjar.javac.BlazeJavacMain.compile(BlazeJavacMain.java:144)
        at com.google.devtools.build.buildjar.ReducedClasspathJavaLibraryBuilder.compileSources(ReducedClasspathJavaLibraryBuilder.java:57)
        at com.google.devtools.build.buildjar.SimpleJavaLibraryBuilder.compileJavaLibrary(SimpleJavaLibraryBuilder.java:110)
        at com.google.devtools.build.buildjar.SimpleJavaLibraryBuilder.run(SimpleJavaLibraryBuilder.java:118)
        at com.google.devtools.build.buildjar.BazelJavaBuilder.build(BazelJavaBuilder.java:111)
        at com.google.devtools.build.buildjar.BazelJavaBuilder.parseAndBuild(BazelJavaBuilder.java:91)
        at com.google.devtools.build.buildjar.BazelJavaBuilder.lambda$main$0(BazelJavaBuilder.java:52)
        at com.google.devtools.build.lib.worker.WorkRequestHandler$WorkRequestCallback.apply(WorkRequestHandler.java:252)
        at com.google.devtools.build.lib.worker.WorkRequestHandler.respondToRequest(WorkRequestHandler.java:480)
        at com.google.devtools.build.lib.worker.WorkRequestHandler.lambda$startResponseThread$1(WorkRequestHandler.java:433)
        at java.base/java.lang.Thread.run(Thread.java:829)
---8<---8<--- End of log ---8<---8<---
Target //java/src/main/java/bazel/bootcamp:HelloBazelBootcamp failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 6.786s, Critical Path: 2.25s
INFO: 8 processes: 6 internal, 2 linux-sandbox.
ERROR: Build did NOT complete successfully
```
