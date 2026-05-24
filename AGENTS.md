# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Purpose

StrataJava is a tiny Java corpus for exercising
[`strata-org/Strata`](https://reservoir.lean-lang.org/@strata-org/Strata) on a
CS 61B-style example. The corpus is intentionally scoped to a single
`ArithmeticFacts` class with two operations — `product` and `sum` — so the
pipeline can prove their commutativity and the stacked distributivity theorem
`product(a, sum(b, c)) == sum(product(a, b), product(a, c))` end-to-end.

## Build & Check

```bash
# Compile the corpus class
./scripts/check-java-corpus.sh

# Compile corpus and validate semantic-chain artifacts (requires uv)
./scripts/check-all.sh

# Build the Lean/Lake project against the pinned Strata dependency
lake build

# Load/type-check the corpus Core sketch through the Lake executable
lake exe stratajava

# Warn on corpus functions missing human-checked review markers
./scripts/check-human-checked-lint.sh

# Minimal warning lint for one or more touched Java files
./scripts/check-human-checked-lint.sh corpus/cs61b-java/src/ArithmeticFacts.java

# Build with Lake and stress the Strata Core target
./scripts/check-lake.sh

# Print the Java main method beside its stdout for easy comparison
uv run scripts/check-main-output.py
```

`check-all.sh` runs the Java compile check, `uv run scripts/check-semantics.py`,
the main-method smoke output in quiet mode, the Lean `human_checked_lint`
warning pass, and the Lake-native Strata check.

For as-you-go guidance, set this repo's local Git hook path once with
`git config core.hooksPath scripts/hooks`. The versioned pre-commit hook runs
`human_checked_lint` only on staged Java corpus files and prints advisory
warnings without turning missing review comments into build errors.

## Corpus Constraints

The single corpus file in `corpus/cs61b-java/src/` must obey these rules
(enforced by convention, not tooling):

- Preserve human review markers and comments in the corpus file, especially
  inline `// human-checked` markers. Do not remove, rewrite, or regenerate them
  unless Alok explicitly asks for that specific change.
- No `throw`, `throws`, `try`, `catch`, or exception classes
- No recursion
- No third-party imports (stdlib only)
- Bounded `for` loops preferred over `while`
- Small standalone `public class` — no packages, no multi-file dependencies

## Structure

- `corpus/cs61b-java/src/ArithmeticFacts.java` — the single corpus source
- `lakefile.toml` / `lean-toolchain` — Lake project using Strata as the pinned
  core dependency
- `StrataJava.lean` and `StrataJava/Main.lean` — Lean wrapper and executable
  that drive Strata over the corpus Core sketch
- `StrataJava/ArithmeticFacts.lean` — Lean translation with the
  product/sum/commutativity/distributivity theorems
- `StrataJava/HumanCheckedLint.lean` — Lean warning linter for public corpus
  functions missing nearby `human-checked` comments
- `metadata/corpus.json` — source of truth: maps the file to its topic, CS 61B
  source probe, and language features used
- `semantics/cs61b-java/stack-semantics.json` — machine-readable chained
  semantics for every corpus method
- `lean/strata/boogie/CoreSketch.core.st` — Strata Core / Boogie-like
  procedure/spec target
- `docs/semantics-stack.md` — explanation of the L0 -> L1 -> L2 -> L3 -> L4 ->
  L5 semantic chain
- `docs/whitepaper.md` — living project white paper; keep this current when
  project framing, goals, or evidence changes
- `docs/complications.md` — running log of constraints and decisions made while
  building the corpus
- `scripts/check-java-corpus.sh` — compile-check script
- `scripts/check-main-output.py` — runs the Java `main` method and can print
  the source snippet next to stdout for inspection
- `scripts/check-semantics.py` — semantic-chain validator
- `scripts/check-human-checked-lint.sh` — minimal wrapper for the Lean
  `human_checked_lint` warning executable; accepts files or directories
- `scripts/check-lake.sh` — Lake-native Strata build/load/VC stress harness
- `scripts/hooks/pre-commit` — versioned hook that runs the human-checked
  warning linter only on staged Java corpus files when `core.hooksPath` is set
- `scripts/check-all.sh` — combined check script

## Adding New Corpus Files

The corpus is intentionally focused on `ArithmeticFacts`. If you re-expand it:

1. Write the `.java` file into `corpus/cs61b-java/src/` respecting all
   constraints above.
2. Add a corresponding entry to `metadata/corpus.json` with `file`, `topic`,
   `source_probe`, and `features` fields.
3. Add or update semantic cards in
   `semantics/cs61b-java/stack-semantics.json`.
4. Add any new Strata target procedure names to
   `lean/strata/boogie/CoreSketch.core.st`.
5. Run `./scripts/check-all.sh` to verify the Java, semantics, and Strata
   artifacts.
6. If the class has a `main` method, run it and confirm it exits successfully.

## Semantic Chain

The distinguishing project claim is chained semantics, not a flat pile of notes.
Every method should connect:

`Java source -> surface summary -> functional relation -> operational story -> verification obligations -> Strata Core target`

Lean/theorem provers can express semantic facts and then use them downstream as
theorem inputs. The `product_distrib_over_sum` theorem is the canonical
demonstration: it consumes the `product_summary` and `sum_summary` facts from
two different functions to discharge a derived obligation. Java and Python
usually leave those facts in comments, human memory, or untrusted summaries.
Keep that distinction explicit in docs and reports.
