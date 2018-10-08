#!/bin/bash

set -euo pipefail

readonly GO_SERVER="${TEST_SRCDIR}/bootcamp/go/cmd/server/linux_amd64_stripped/go-server"
readonly JAVA_CLIENT="${TEST_SRCDIR}/bootcamp/java/src/main/java/bootcamp/JavaLoggingClient"

"$GO_SERVER" &
readonly PID="$!"
"$JAVA_CLIENT" <<< "message" <<< "exit"
kill "$PID"
cat /tmp/bootcamp_server_last_message.txt | grep -o message
