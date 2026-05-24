#!/usr/bin/env bash
# Drive leanprover/comparator over the StrataJava Challenge/Solution pair.
# Confirms the proofs in Solution.lean prove the same statements as the sorries
# in Challenge.lean while using only the axioms allowed by comparator-config.json.

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

config="$repo_root/comparator-config.json"
comparator_bin="$repo_root/.lake/packages/Comparator/.lake/build/bin/comparator"
lean4export_bin="$repo_root/.lake/packages/lean4export/.lake/build/bin/lean4export"
fake_landrun="$repo_root/scripts/fake-landrun.sh"

if [[ ! -f "$config" ]]; then
  echo "Missing config: $config" >&2
  exit 1
fi
if [[ ! -x "$comparator_bin" || ! -x "$lean4export_bin" ]]; then
  echo "Comparator/lean4export not built; running 'lake build comparator lean4export'..." >&2
  lake build comparator lean4export
fi

# Pre-build the Challenge and Solution oleans so comparator's sandboxed lake
# invocation has them ready (and so build failures surface here, not inside the
# sandbox where the diagnostics are harder to read).
lake build Challenge Solution

# Pick landrun: real on Linux when available, fake shim everywhere else.
landrun_path=""
case "$(uname -s)" in
  Linux)
    if command -v landrun >/dev/null 2>&1; then
      landrun_path="$(command -v landrun)"
    else
      landrun_path="$fake_landrun"
      echo "WARNING: landrun not in PATH; using fake-landrun.sh (sandbox guarantees disabled)" >&2
    fi
    ;;
  *)
    landrun_path="$fake_landrun"
    echo "WARNING: non-Linux platform; using fake-landrun.sh (sandbox guarantees disabled)" >&2
    ;;
esac

COMPARATOR_LANDRUN="$landrun_path" \
COMPARATOR_LEAN4EXPORT="$lean4export_bin" \
  lake env "$comparator_bin" "$config"
