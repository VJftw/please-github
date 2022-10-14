#!/usr/bin/env bash
# This script generates a JSON list of available Please targets to perform for this repository.
set -Eeuo pipefail

JQ="//third_party/binary:jq"

source "//build/util"
source "//third_party/sh:shflags"

DEFINE_string 'changes_file' 'plz-out/changes' 'path to file with list of Please targets to include. This is skipped if empty/non-existent.' 'c'
DEFINE_string 'out_file' 'plz-out/github/please_targets.json' 'path to file to write the JSON list of Please targets to.' 'o'
DEFINE_string 'includes' '' 'comma separated extra labels to filter Please targets by.' 'i'
DEFINE_string 'excludes' '' 'comma separated extra labels to filter Please targets by.' 'e'
DEFINE_string 'query_path' '//...' 'The Please query path to search.' 'q'

FLAGS "$@" || exit $?
eval set -- "${FLAGS_ARGV}"

args=(
    "query"
    "alltargets"
    "--plain_output"
)

if [ -n "${FLAGS_includes}" ]; then
    args+=("--include" "${FLAGS_includes}")
fi

if [ -n "${FLAGS_excludes}" ]; then
    # we want excludes to be OR'd so we pass them as unique flags.
    mapfile -t excludes < <(echo -e "${FLAGS_excludes//,/\\n}")
    for exclude in "${excludes[@]}"; do
        args+=("--exclude" "${exclude}")
    done
fi

args+=("${FLAGS_query_path}")

echo "${args[@]}"
mapfile -t please_targets < <(./pleasew "${args[@]}")

# Filter please_targets to just changed targets if changes_file is non-empty.
if [ -f "${FLAGS_changes_file}" ]; then
    mapfile -t changes < "${FLAGS_changes_file}"
    if [ ${#changes[@]} -ne 0 ]; then
        new_please_targets=()
        for please_job in "${please_targets[@]}"; do
            if util::contains "$please_job" "${changes[@]}"; then
                new_please_targets+=("$please_job")
            fi
        done
        please_targets=("${new_please_targets[@]}")
    fi
fi

mkdir -p "$(dirname "${FLAGS_out_file}")"

if [ ${#please_targets[@]} -eq 0  ]; then
    echo "[]" | jq -c . > "${FLAGS_out_file}"
else
    jsonified_please_targets=$(printf "%s\n" "${please_targets[@]}" \
        | "$JQ" -R . \
        | "$JQ" -s .
    )
    printf "%s" "${jsonified_please_targets}" | "$JQ" -c . > "${FLAGS_out_file}"
fi

util::success "Wrote ${#please_targets[@]} Please targets to ${FLAGS_out_file}"

cat "${FLAGS_out_file}"
