# Lean / Strata / Boogie Target

This directory is the build-facing Lean/Strata/Boogie entrypoint for the
StrataJava corpus.

`CoreSketch.core.st` is the canonical L5 Strata Core target. The semantic
JSON in `semantics/cs61b-java/stack-semantics.json` points at procedure names
in this file (`ArithmeticFacts_product`, `ArithmeticFacts_sum`,
`ArithmeticFacts_product_distrib_over_sum`).

Build it with:

```bash
./scripts/check-lake.sh
```

The script builds the pinned Strata dependency via Lake, parses this Core
file, type-checks it, generates SMT-LIB verification conditions, and runs the
available solver.
