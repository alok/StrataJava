# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

StrataJava is a small Java corpus for exercising [`strata-org/Strata`](https://reservoir.lean-lang.org/@strata-org/Strata) on CS 61B-style programs. The corpus intentionally stays within a narrow subset of Java so Strata's analysis remains tractable.

## Build & Check

```bash
# Compile all corpus files (requires fd and javac)
./scripts/check-java-corpus.sh

# Compile corpus and validate semantic-chain artifacts (requires uv)
./scripts/check-all.sh

# Stress the Strata Core target against a Strata checkout
STRATA_DIR=/path/to/Strata ./scripts/check-strata-core.sh

# Stress the Lean/Strata/Boogie-facing path
STRATA_DIR=/path/to/Strata ./scripts/check-lean-strata-boogie.sh
```

This compiles every `.java` file under `corpus/cs61b-java/src/` into `build/classes/cs61b-java/`. The script uses `fd` (not `find`), so `fd` must be installed.

To run a single compiled class:
```bash
java -cp build/classes/cs61b-java <ClassName>
```

`check-all.sh` runs the Java compile check, `uv run scripts/check-semantics.py`,
and the Strata Core stress check when a Strata checkout is available. Run
`scripts/check-strata-core.sh` directly when Strata must be treated as required.

## Corpus Constraints

Every file in `corpus/cs61b-java/src/` must obey these rules (enforced by convention, not tooling):

- No `throw`, `throws`, `try`, `catch`, or exception classes
- No recursion
- No third-party imports (stdlib only)
- Bounded `for` loops preferred over `while`
- Small standalone `public class` — no packages, no multi-file dependencies

## Structure

- `corpus/cs61b-java/src/` — the 50 standalone Java source files
- `metadata/corpus.json` — source of truth: maps each file to its topic, CS 61B source probe (the Berkeley skeleton file that motivated it), and language features used
- `semantics/cs61b-java/stack-semantics.json` — machine-readable chained semantics for every corpus method
- `semantics/strata-core/cs61b-java/CoreSketch.core.st` — Strata Core / Boogie-like semantic target sketch
- `lean/strata/boogie/` — Lean/Strata/Boogie-facing build path for the same Core target
- `docs/semantics-stack.md` — explanation of the L0 -> L1 -> L2 -> L3 -> L4 -> L5 semantic chain
- `docs/whitepaper.md` — living project white paper; keep this current when project framing, goals, or evidence changes
- `docs/complications.md` — running log of constraints and decisions made while building the corpus
- `scripts/check-java-corpus.sh` — compile-check script
- `scripts/check-semantics.py` — semantic-chain validator
- `scripts/check-strata-core.sh` — Strata parse/typecheck/VC stress harness
- `scripts/check-lean-strata-boogie.sh` — stress harness for `lean/strata/boogie/CoreSketch.core.st`
- `scripts/check-all.sh` — combined check script

## Adding New Corpus Files

1. Write the `.java` file into `corpus/cs61b-java/src/` respecting all constraints above.
2. Add a corresponding entry to `metadata/corpus.json` with `file`, `topic`, `source_probe`, and `features` fields.
3. Add or update semantic cards in `semantics/cs61b-java/stack-semantics.json`.
4. Add any new Strata target procedure names to `semantics/strata-core/cs61b-java/CoreSketch.core.st`.
5. Run `./scripts/check-all.sh` to verify the Java, semantics, and available
   Strata artifacts.
6. Run `./scripts/check-strata-core.sh` with `STRATA_DIR` set when Strata must
   be treated as a hard dependency.
7. If the class has a `main` method, run it and confirm it exits successfully.

## Semantic Chain

The distinguishing project claim is chained semantics, not a flat pile of notes.
Every method should connect:

`Java source -> surface summary -> functional relation -> operational story -> verification obligations -> Strata Core target`

Lean/theorem provers can express semantic facts and then use them downstream as
theorem inputs. Java and Python usually leave those facts in comments, human
memory, or untrusted summaries. Keep that distinction explicit in docs and
reports.
