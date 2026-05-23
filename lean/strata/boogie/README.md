# Lean / Strata / Boogie Target

This directory is the build-facing Lean/Strata/Boogie entrypoint for the
StrataJava corpus.

`CoreSketch.core.st` is intentionally kept as the same artifact as the semantic
L5 target in `semantics/strata-core/cs61b-java/CoreSketch.core.st`. The
semantic JSON points at procedure names in that target, while this directory
gives the Lean/Strata/Boogie side a stable path to build and inspect.

Build it with:

```bash
./scripts/check-lean-strata-boogie.sh
```

The script builds the configured Strata checkout, parses this Core file,
type-checks it, generates SMT-LIB verification conditions, and runs the
available solver.
