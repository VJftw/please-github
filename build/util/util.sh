#!/usr/bin/env bash
set -Eeuo pipefail

source "//third_party/sh:ansi"

util::debug() {
    set -x; "$@"; set +x;
}

util::info() {
    printf "$(ansi::resetColor)$(ansi::magentaIntense)💡 %s$(ansi::resetColor)\n" "$@"
}

util::warn() {
  printf "$(ansi::resetColor)$(ansi::yellowIntense)⚠️  %s$(ansi::resetColor)\n" "$@"
}

util::error() {
  printf "$(ansi::resetColor)$(ansi::bold)$(ansi::redIntense)❌ %s$(ansi::resetColor)\n" "$@"
}

util::success() {
  printf "$(ansi::resetColor)$(ansi::greenIntense)✅ %s$(ansi::resetColor)\n" "$@"
}

util::retry() {
  "${@}" || sleep 1; "${@}" || sleep 5; "${@}"
}

util::prompt() {
  prompt=$(printf "$(ansi::bold)$()❔ %s [y/N]$(ansi::resetColor)\n" "$@")
  read -rp "${prompt}" yn
  case $yn in
      [Yy]* ) ;;
      * ) util::error "Did not receive happy input, exiting."; exit 1;;
  esac
}

util::prompt_skip() {
  prompt=$(printf "$(ansi::bold)$()❔ %s [y/N]$(ansi::resetColor)\n" "$@")
  read -rp "${prompt}" yn
  case $yn in
      [Yy]* ) return 0;;
      * ) util::warn "Did not receive happy input, skipping."; return 1;;
  esac
}

util::contains() {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}
