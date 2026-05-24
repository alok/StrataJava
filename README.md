# StrataJava

Minimal Java corpus for exercising
[`strata-org/Strata`](https://reservoir.lean-lang.org/@strata-org/Strata)
on a CS 61B-style example.

The corpus is intentionally tiny: a single `ArithmeticFacts` class with the
two operations we verify downstream — `product` and `sum`. The headline claim
is the stacked theorem `product_distrib_over_sum`, which requires combining
the spec of `product` with the spec of `sum`.

Corpus constraints:

- No `throw`, `try`, `catch`, or checked/unchecked failure classes.
- No recursion or third-party Java libraries.
- Bounded `for` loops; plain `if` branches and function calls.

## Check

```bash
./scripts/check-java-corpus.sh   # compile the corpus
./scripts/check-all.sh           # full pipeline: javac + semantics + Lake/Strata
lake build                       # Lean type-check + theorem verification
lake exe stratajava              # run the Strata sketch via the Lake wrapper
```

`check-all.sh` runs the Java compile check, the semantic-chain validator, the
Java `main` smoke harness, the human-checked Java lint, and the Lake-native
Strata check against `lean/strata/boogie/CoreSketch.core.st`.

## Layout

- `corpus/cs61b-java/src/ArithmeticFacts.java` — the Java source.
- `StrataJava/ArithmeticFacts.lean` — Lean translation with the commutativity
  and distributivity theorems.
- `lean/strata/boogie/CoreSketch.core.st` — Strata Core procedure/spec sketch.
- `semantics/cs61b-java/stack-semantics.json` — semantic-chain index.
- `metadata/corpus.json` — corpus manifest.
- `docs/whitepaper.md`, `docs/semantics-stack.md`, `docs/complications.md` —
  project documentation.
