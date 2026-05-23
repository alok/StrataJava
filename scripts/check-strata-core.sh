#!/usr/bin/env bash
set -euo pipefail

optional=0
if [[ "${1:-}" == "--if-available" ]]; then
  optional=1
  shift
fi

if [[ $# -ne 0 ]]; then
  echo "usage: STRATA_DIR=/path/to/Strata $0 [--if-available]" >&2
  exit 2
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
core_file="$repo_root/semantics/strata-core/cs61b-java/CoreSketch.core.st"

strata_dir="${STRATA_DIR:-}"
if [[ -z "$strata_dir" ]]; then
  for candidate in "/tmp/stratajava-Strata" "$repo_root/../Strata" "$HOME/Strata"; do
    if [[ -f "$candidate/lakefile.toml" ]]; then
      strata_dir="$candidate"
      break
    fi
  done
fi

if [[ -z "$strata_dir" || ! -f "$strata_dir/lakefile.toml" ]]; then
  if [[ "$optional" -eq 1 ]]; then
    echo "Skipping Strata Core stress check: set STRATA_DIR to a Strata checkout."
    exit 0
  fi
  echo "No Strata checkout found. Set STRATA_DIR=/path/to/Strata." >&2
  exit 1
fi

if [[ ! -f "$core_file" ]]; then
  echo "Missing Core sketch: $core_file" >&2
  exit 1
fi

vc_dir="$repo_root/build/strata-vcs"
rm -rf "$vc_dir"
mkdir -p "$vc_dir"
vc_log="$vc_dir/no-solve.log"
solve_log="$vc_dir/solver.log"

echo "Using Strata checkout: $strata_dir"
echo "Using Core sketch: $core_file"

(
  cd "$strata_dir"
  lake build strata
  lake exe strata verify --parse-only "$core_file"
  lake exe strata verify --type-check "$core_file"
)

set +e
(
  cd "$strata_dir"
  lake exe strata verify \
    --no-solve \
    --vc-directory "$vc_dir" \
    --check-level full \
    "$core_file"
) >"$vc_log" 2>&1
vc_status=$?
set -e

if [[ "$vc_status" -ne 0 && "$vc_status" -ne 2 ]]; then
  echo "Strata VC generation failed with exit code $vc_status" >&2
  tail -40 "$vc_log" >&2
  exit "$vc_status"
fi

smt_count="$(fd -e smt2 . "$vc_dir" | wc -l | tr -d ' ')"
echo "Generated $smt_count SMT-LIB verification condition files in $vc_dir"
vc_summary="$(rg "All [0-9]+ goals passed|Finished with" "$vc_log" | tail -1 || true)"
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

(
  cd "$strata_dir"
  set +e
  lake exe strata verify \
    --solver "$solver" \
    --solver-timeout "${STRATA_SOLVER_TIMEOUT:-10}" \
    --check-level full \
    "$core_file"
  solve_status=$?
  set -e
  exit "$solve_status"
) >"$solve_log" 2>&1
solve_status=$?
solve_summary="$(rg "All [0-9]+ goals passed|Finished with" "$solve_log" | tail -1 || true)"
if [[ "$solve_status" -eq 0 ]]; then
  if [[ -n "$solve_summary" ]]; then
    echo "Solver summary: $solve_summary"
  fi
  echo "Strata Core stress check passed with solver: $solver"
elif [[ "$solve_status" -eq 2 ]]; then
  if [[ -n "$solve_summary" ]]; then
    echo "Solver summary: $solve_summary"
  fi
  echo "Solver completed and reported unproven/failing obligations; parse, typecheck, and VC generation still passed."
else
  echo "Strata solver run failed with exit code $solve_status" >&2
  tail -40 "$solve_log" >&2
  exit "$solve_status"
fi
