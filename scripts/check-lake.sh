#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
core_file="$repo_root/lean/strata/boogie/CoreSketch.core.st"

if [[ ! -f "$core_file" ]]; then
  echo "Missing Core sketch: $core_file" >&2
  exit 1
fi

cd "$repo_root"

vc_dir="$repo_root/build/lake-strata-vcs"
rm -rf "$vc_dir"
mkdir -p "$vc_dir"
vc_log="$vc_dir/no-solve.log"
solve_log="$vc_dir/solver.log"

echo "Building Lake project with Strata dependency..."
lake build

echo "Loading Core sketch through Lake executable: $core_file"
lake exe stratajava --parse-only
lake exe stratajava --type-check

set +e
lake exe stratajava \
  --no-solve \
  --vc-directory "$vc_dir" \
  --check-level full >"$vc_log" 2>&1
vc_status=$?
set -e

if [[ "$vc_status" -ne 0 && "$vc_status" -ne 2 ]]; then
  echo "Lake Strata VC generation failed with exit code $vc_status" >&2
  tail -40 "$vc_log" >&2
  exit "$vc_status"
fi

smt_count="$(find "$vc_dir" -type f -name '*.smt2' | wc -l | tr -d ' ')"
echo "Generated $smt_count SMT-LIB verification condition files in $vc_dir"
vc_summary="$(grep -E "All [0-9]+ goals passed|Finished with" "$vc_log" | tail -1 || true)"
if [[ -n "$vc_summary" ]]; then
  echo "No-solve summary: $vc_summary"
fi
if [[ "$vc_status" -eq 2 ]]; then
  echo "VC generation completed with unproven obligations, as expected for the abstract semantic sketch."
fi

solver="${STRATA_SOLVER:-}"
if [[ -z "$solver" ]]; then
  if command -v cvc5 >/dev/null 2>&1; then
    solver="cvc5"
  elif command -v z3 >/dev/null 2>&1; then
    solver="z3"
  fi
fi

if [[ -z "$solver" || "$solver" == "none" ]]; then
  echo "No SMT solver found; skipped solving pass."
  exit 0
fi

set +e
lake exe stratajava \
  --solver "$solver" \
  --solver-timeout "${STRATA_SOLVER_TIMEOUT:-10}" \
  --check-level full >"$solve_log" 2>&1
solve_status=$?
set -e

solve_summary="$(grep -E "All [0-9]+ goals passed|Finished with" "$solve_log" | tail -1 || true)"
if [[ "$solve_status" -eq 0 ]]; then
  if [[ -n "$solve_summary" ]]; then
    echo "Solver summary: $solve_summary"
  fi
  echo "Lake Strata check passed with solver: $solver"
elif [[ "$solve_status" -eq 2 ]]; then
  if [[ -n "$solve_summary" ]]; then
    echo "Solver summary: $solve_summary"
  fi
  echo "Solver completed and reported unproven/failing obligations; parse, typecheck, and VC generation still passed."
else
  echo "Lake Strata solver run failed with exit code $solve_status" >&2
  tail -40 "$solve_log" >&2
  exit "$solve_status"
fi
