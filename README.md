# StrataJava

Small Java corpus for exercising [`strata-org/Strata`](https://reservoir.lean-lang.org/@strata-org/Strata)
on CS 61B-style programs.

The corpus is intentionally conservative:

- 50 standalone Java files.
- No `throw`, `try`, `catch`, or checked/unchecked failure classes in the corpus
  sources.
- Bounded `for` loops over integers, arrays, or strings.
- Plain `if` branches and ordinary function/method calls.
- No recursion.
- No third-party Java libraries.

The files are original small programs, not verbatim copies of Berkeley source.
The `metadata/corpus.json` file records the public CS 61B source probes that
motivated each topic.

## Check

```bash
./scripts/check-java-corpus.sh
```

This compiles every file under `corpus/cs61b-java/src` into
`build/classes/cs61b-java`.

To validate the Java corpus and the attached semantics stack:

```bash
./scripts/check-all.sh
```

To stress the current Strata checkout against the generated Core target:

```bash
STRATA_DIR=/path/to/Strata ./scripts/check-strata-core.sh
```

The Lean/Strata/Boogie-facing path is also available directly:

```bash
STRATA_DIR=/path/to/Strata ./scripts/check-lean-strata-boogie.sh
```

If `STRATA_DIR` is omitted, the script first tries `/tmp/stratajava-Strata` and
then `../Strata`. The check builds Strata's `strata` executable, parses the
Core sketch, type-checks it, generates full-check verification conditions, and
runs the available SMT solver (`cvc5` or `z3`) when present.

The semantics artifacts live under `semantics/` and are described in
`docs/semantics-stack.md`. The project white paper is kept at
`docs/whitepaper.md`.
