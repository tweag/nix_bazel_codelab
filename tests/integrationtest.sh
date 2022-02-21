#!/usr/bin/env bash
set -euo pipefail

readonly GO_SERVER="$(find "${TEST_SRCDIR}" -name go-server)"
readonly JAVA_CLIENT="$(find "${TEST_SRCDIR}" -name JavaLoggingClient)"

"$GO_SERVER" &
readonly GO_SERVER_PID="$!"

"$JAVA_CLIENT" <<EOF
message
exit
EOF

cat /tmp/bootcamp_server_last_message.txt | grep -o message
kill "$GO_SERVER_PID"
rm /tmp/bootcamp_server_last_message.txt