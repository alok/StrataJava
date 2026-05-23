#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
core_file="$repo_root/lean/strata/boogie/CoreSketch.core.st"

CORE_FILE="$core_file" "$repo_root/scripts/check-strata-core.sh" "$@"
