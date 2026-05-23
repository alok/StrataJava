# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

StrataJava is a small Java corpus for exercising [`strata-org/Strata`](https://reservoir.lean-lang.org/@strata-org/Strata) on CS 61B-style programs. The corpus intentionally stays within a narrow subset of Java so Strata's analysis remains tractable.

## Build & Check

```bash
# Compile all corpus files (requires fd and javac)
./scripts/check-java-corpus.sh
```

This compiles every `.java` file under `corpus/cs61b-java/src/` into `build/classes/cs61b-java/`. The script uses `fd` (not `find`), so `fd` must be installed.

To run a single compiled class:
```bash
java -cp build/classes/cs61b-java <ClassName>
```

## Corpus Constraints

Every file in `corpus/cs61b-java/src/` must obey these rules (enforced by convention, not tooling):

- No `throw`, `throws`, `try`, `catch`, or exception classes
- No recursion
- No third-party imports (stdlib only)
- Bounded `for` loops preferred over `while`
- Small standalone `public class` — no packages, no multi-file dependencies

## Structure

- `corpus/cs61b-java/src/` — the 10 standalone Java source files
- `metadata/corpus.json` — source of truth: maps each file to its topic, CS 61B source probe (the Berkeley skeleton file that motivated it), and language features used
- `docs/complications.md` — running log of constraints and decisions made while building the corpus
- `scripts/check-java-corpus.sh` — compile-check script

## Adding New Corpus Files

1. Write the `.java` file into `corpus/cs61b-java/src/` respecting all constraints above.
2. Add a corresponding entry to `metadata/corpus.json` with `file`, `topic`, `source_probe`, and `features` fields.
3. Run `./scripts/check-java-corpus.sh` to verify it compiles.
4. If the class has a `main` method, run it and confirm it exits successfully.
