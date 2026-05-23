#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

if [[ "$#" -eq 0 ]]; then
  lake exe human_checked_lint
else
  lake exe human_checked_lint "$@"
fi
