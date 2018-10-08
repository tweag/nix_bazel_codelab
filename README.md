# This repository contains the completed source code for the Bazel Bootcamp to be presented at BazelCon 2018.

## Section 1 (backend, java only for now)

1.  Add a java_binary target for the HelloBazelBootcamp class
1.  Add a java_library target called "hello-world-server-lib" for the server
1.  Add a java_binary target called "hello-world-server" for the server that
    depends on "hello-world-server-lib"
1.  Run each binary using `bazel run`

## Section 2 (unit tests)

## Section 3 (client, java for now)

1.  Add a java_library target called "hello-world-client-lib" for the client
1.  Add a java_binary target called "hello-world-client" that depends on
    "hello-world-client-lib"
1.  Run the binary using `bazel run`

## Section 4 (android, demo only)

1.  (Install android studio)[https://developer.android.com/studio/install#linux]
    Follow the steps and make sure you also install the SDK during this process.
1.  Use the avd manager (Tools > AVD Manager) to create a virtual device (pixel
    with oreo is fine). This will require you to download a system image.
1.  Boot up an emulator using the AVD manager.
1.  Run the server from Section 1
1.  Build and install the app using mobile-install: `bazel
    mobile-install :android-client`
1.  Use host=10.0.2.2 and port=50051 when the app boots in the emulator

## Section 5 (integration tests)

## Section 6 (query)
