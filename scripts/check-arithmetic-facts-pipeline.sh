#!/usr/bin/env bash
# Pipeline test for ArithmeticFacts.java → Strata Core → Lean.
#
# Stages:
#   1. Compile the Java source.
#   2. Run the Java main method (smoke check).
#   3. Build the Lean project — this type-checks ArithmeticFacts.lean
#      and verifies all theorems.
#   4. Optionally run the focused Strata Core sketch through Strata
#      (when STRATA_DIR is set).
#
# Usage:
#   ./scripts/check-arithmetic-facts-pipeline.sh
#   STRATA_DIR=/path/to/Strata ./scripts/check-arithmetic-facts-pipeline.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JAVA_SRC="$REPO_ROOT/corpus/cs61b-java/src/ArithmeticFacts.java"
BUILD_DIR="$REPO_ROOT/build/classes/cs61b-java"
CORE_SKETCH="$REPO_ROOT/lean/strata/boogie/arithmetic-facts/ArithmeticFacts.core.st"

echo "=== Stage 1: compile ArithmeticFacts.java ==="
mkdir -p "$BUILD_DIR"
javac -d "$BUILD_DIR" "$JAVA_SRC"
echo "OK"

echo ""
echo "=== Stage 2: run ArithmeticFacts.main (smoke) ==="
java -cp "$BUILD_DIR" ArithmeticFacts
echo "OK"

echo ""
echo "=== Stage 3: lake build (Lean type-check + theorem verification) ==="
cd "$REPO_ROOT"
lake build StrataJava
echo "OK"

echo ""
echo "=== Stage 4: Strata Core sketch ==="
if [ -n "${STRATA_DIR:-}" ]; then
    echo "Using Strata checkout at $STRATA_DIR"
    STRATA_BIN="$STRATA_DIR/.lake/build/bin/strata"
    if [ ! -x "$STRATA_BIN" ]; then
        echo "Building Strata..."
        (cd "$STRATA_DIR" && lake build strata)
    fi
    echo "Parsing and type-checking $CORE_SKETCH ..."
    "$STRATA_BIN" verify --type-check "$CORE_SKETCH"
    echo "OK"
else
    echo "STRATA_DIR not set — skipping Strata verification."
    echo "(Set STRATA_DIR=/path/to/Strata to enable this stage.)"
fi

echo ""
echo "=== ArithmeticFacts pipeline test: PASSED ==="
