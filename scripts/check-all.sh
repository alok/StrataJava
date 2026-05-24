#!/usr/bin/env bash
set -eu

./scripts/check-java-corpus.sh
uv run scripts/check-semantics.py
uv run scripts/check-main-output.py --quiet --no-compile
./scripts/check-human-checked-lint.sh
./scripts/check-lake.sh
