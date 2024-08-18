#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/zephyrproject-rtos/sdk-ng"
TOOL_NAME="zephyr-sdk"

info() {
  echo -e "asdf-${TOOL_NAME}: $*"
}

fail() {
  echo -e "asdf-${TOOL_NAME}: $*"
  exit 1
}

get_platform() {
  uname | tr '[:upper:]' '[:lower:]' | sed 's/darwin/macos/g'
}

get_arch() {
  uname -m | sed 's/arm64/aarch64/g'
}

list_all_versions() {
  git ls-remote --tags --refs $GH_REPO \
    | grep -o 'refs/tags/.*' \
    | cut -d/ -f3- \
    | grep -v '-' \
    | sed 's/^v//' \
    | sort -V \
    | xargs echo
}
