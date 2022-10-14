#!/usr/bin/env bash
set -Eeuo pipefail

source "//build/util"

ACTIONLINT="//third_party/binary:rhysd_actionlint"

util::info "checking GitHub Actions Workflows"
"$ACTIONLINT" -shellcheck= -pyflakes=

util::success "checked GitHub Actions Workflows"
