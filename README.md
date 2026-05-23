# StrataJava

Small Java corpus for exercising [`strata-org/Strata`](https://reservoir.lean-lang.org/@strata-org/Strata)
on CS 61B-style programs.

The first corpus is intentionally conservative:

- 10 standalone Java files.
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

The semantics artifacts live under `semantics/` and are described in
`docs/semantics-stack.md`. The project white paper is kept at
`docs/whitepaper.md`.
