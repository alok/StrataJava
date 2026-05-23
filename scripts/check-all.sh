#!/usr/bin/env bash
set -eu

./scripts/check-java-corpus.sh
uv run scripts/check-semantics.py
uv run scripts/check-main-output.py --quiet --no-compile
./scripts/check-lean-strata-boogie.sh --if-available
