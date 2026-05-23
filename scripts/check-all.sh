#!/usr/bin/env bash
set -eu

./scripts/check-java-corpus.sh
uv run scripts/check-semantics.py
