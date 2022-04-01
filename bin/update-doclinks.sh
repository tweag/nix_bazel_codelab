#! /usr/bin/env nix-shell
#! nix-shell -i bash ../shell.nix

# this script updates the links to Bazel's docs in the README.md file to directly link to
# the version that is specified in .bazeliskrc

set -EeuCo pipefail

declare -a BAZEL_VERSION

mapfile -n 1 -t BAZEL_VERSION < <( sed -ne 's/USE_BAZEL_VERSION=//p ; T ; q' .bazeliskrc )

echo "linking to Bazel docs version ${BAZEL_VERSION[0]}"

sed -i -Ee "s,(https://docs.bazel.build/versions/)([^/]*)/,\1${BAZEL_VERSION[0]}/,g" README.md
