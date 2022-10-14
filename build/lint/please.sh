#!/usr/bin/env bash
set -Eeuo pipefail

source "//build/util"

util::info "checking BUILD files"
if ! ./pleasew fmt --quiet; then
  util::error "BUILD files incorrectly formatted. Please run:
  $ ./pleasew fmt-all"
  exit 1
fi
util::success "checked BUILD files"
