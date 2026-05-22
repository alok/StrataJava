# Complications Log

This file records constraints, complications, and decisions while building the
first StrataJava corpus.

## 2026-05-22

- The local repository was empty at start except for `.git` and `.jj`; the
  parent instructions prefer `jj` when `.jj` exists, so commits should be made
  through `jj`.
- User clarified the first corpus should avoid exceptions and focus on bounded
  `for` loops, `if` branches, and ordinary function calls. Avoid unbounded
  recursion where possible.
- Linear did not show a StrataJava-specific issue in the quick search, so a new
  Linear project `StrataJava` and issue `ALOK-743` were created for tracking.
- Limitless context scraping is a separate part of the broader request. Prior
  local memory says the direct Limitless API path has returned `403 Forbidden`
  before; if/when that part is attempted, prefer the OAuth-backed MCP/local app
  fallback rather than retrying the same direct API blindly.
- The scraped official Berkeley-CS61B skeleton repositories did not show a
  top-level `LICENSE` or `COPYING` file in a quick scan. Decision: use those
  repositories as topic/source probes only and write original, small Java files
  with attribution metadata instead of copying Berkeley source verbatim.
- The first corpus compiles with `javac` and the source-only scan found no
  `throw`, `throws`, `try`, `catch`, `Exception`, `while`, or recursion marker
  in `corpus/cs61b-java/src`.
- Each corpus class with a `main` method was run from the compiled output with
  stdout discarded; all 10 exited successfully.
