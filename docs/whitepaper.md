# Chained Semantics for Java Programs in Lean

Status: living white paper for the StrataJava hackathon track.

## Abstract

Most programming languages can execute code, type-check code, and host comments
about code, but they cannot make semantic facts first-class objects that later
tools can reuse. A Java method can compute an even number, preserve an array
ordering, or maintain a union-find equivalence relation, but Java itself has no
native theorem layer where those facts become durable and composable.

This project explores a small, concrete path through that gap. We collect
simple CS 61B-style Java programs, attach a chain of semantics to each one, and
target Strata/Boogie-like verification artifacts hosted in Lean. The important
claim is not merely "translate Java syntax to Lean." The important claim is:
Lean can express semantic facts as theorems and then use those facts in later
semantic layers, while ordinary Java, Python, and similar languages generally
cannot.

## Origin And Constraints

The project direction comes from the Wednesday 2026-05-20 SPS hackathon notes in
Limitless. The relevant thread identified several constraints:

- Syntax translation is a base layer, not the main value.
- Semantics is the interesting layer: facts like "this function always returns
  an even number" or "this result equals the finite sum of the input array."
- Informal comments or assignment-style specs can provide immediate semantics.
  A useful deliverable is to lift those into formal statements.
- Java/Boogie is a deliberately simpler path than Python because Python's
  dynamic behavior makes the semantic chain harder to derisk in a weekend.
- Strata matters because it can host Boogie-like intermediate verification
  languages in Lean, and Lean can then provide theorem-prover leverage.
- Early success can be compile-and-read rather than fully mechanized proof
  automation. Generated artifacts should compile when possible and be inspectable
  by humans.

The current corpus therefore uses small Java programs with bounded `for` loops,
conditionals, arrays, strings, and simple object methods. It avoids exceptions,
unbounded recursion, and Python-style dynamic dispatch issues.

## Core Thesis

The distinguishing feature is semantic chaining.

In a normal language workflow, semantic knowledge tends to be trapped in one of
three places:

- It is implicit in the source code.
- It is written informally in a comment.
- It is known by a human or inferred by an AI, but not stored in a form the next
  tool can safely reuse.

Lean changes the shape of the workflow. A semantic fact can become a theorem.
Once a fact is a theorem, later tools and later proofs can use it as an input
rather than rediscover it from scratch.

For example:

1. A Java comment says a method doubles every character.
2. A surface semantic layer says `doubleUp` repeats each character twice.
3. A functional layer states that the output length is twice the input length.
4. An operational layer explains that each loop iteration appends two
   characters.
5. A verification layer proves or records the loop invariant.
6. A Strata/Lean layer exposes the result as a reusable theorem-like target:
   `strlen(result) = 2 * strlen(text)`.
7. A later method, `doubledLength`, uses that fact instead of reproving the
   internals of `doubleUp`.

This is the chain: semantics are not just labels attached to a program; each
semantic layer produces facts that the next layer consumes.

## Why Java And Boogie Before Python

Python is appealing because there is a large body of Python code and many users
care about it. It is a poor first target for a hackathon because its dynamism
pushes many semantic questions into runtime:

- late binding,
- dynamic attribute lookup,
- mutable dictionaries everywhere,
- monkey patching,
- implicit exceptions,
- library-heavy behavior,
- ambiguous numeric and container protocols.

Java is unpleasant but useful here. It has familiar syntax, a stable type
system, abundant small teaching examples, and a long history of verification
tooling around Java-adjacent intermediate languages. Boogie is also a natural
bridge because it already looks like a verification-oriented intermediate
language with `requires`, `ensures`, procedures, and verification conditions.
Strata Core is designed around a similar Boogie-like deductive-verification
surface.

That makes Java -> Boogie/Strata a lower-risk route to demonstrate the core
idea: semantic facts can be lifted into Lean and then reused.

## The Semantic Chain

The repository uses six chain positions:

| Position | Layer | Role |
| --- | --- | --- |
| L0 | Java source | Concrete code: method bodies, loops, calls, arrays. |
| L1 | Surface semantics | Short human-readable intent, close to a comment or assignment spec. |
| L2 | Functional semantics | Mathematical input/output relation. |
| L3 | Operational semantics | How execution steps implement the relation. |
| L4 | Verification semantics | Preconditions, postconditions, invariants, and frame conditions. |
| L5 | Strata Core sketch | Boogie-like named target that can be interpreted by Strata/Lean. |

The links matter as much as the nodes:

| Link | Meaning |
| --- | --- |
| L0 -> L1 | Read source and summarize intent. |
| L1 -> L2 | Turn informal intent into a precise relation. |
| L2 -> L3 | Explain why execution realizes the relation. |
| L3 -> L4 | Extract proof obligations from the execution story. |
| L4 -> L5 | Encode obligations as Strata/Boogie-like procedure specs. |

In theorem-prover terms, each link should eventually be a checked refinement or
soundness statement. For now, the repo stores structured claims and validates
that every method has a complete chain and a Strata Core target.

## Current Artifact Set

The current implementation has:

- 50 Java corpus files under `corpus/cs61b-java/src`.
- A machine-readable corpus manifest at `metadata/corpus.json`.
- Chained semantics at `semantics/cs61b-java/stack-semantics.json`.
- A Strata Core sketch at
  `semantics/strata-core/cs61b-java/CoreSketch.core.st`.
- A semantics-chain explainer at `docs/semantics-stack.md`.
- A running complications log at `docs/complications.md`.
- Validation scripts:
  - `scripts/check-java-corpus.sh`
  - `scripts/check-semantics.py`
  - `scripts/check-strata-core.sh`
  - `scripts/check-all.sh`

The validation checks that every Java file has semantics, every method has the
required layers, the global chain is present and ordered, and every method's
`strata_core` target appears in the Core sketch. The Strata stress harness then
uses the current `lake exe strata verify` interface to parse, type-check, and
generate verification conditions for the Core target, with an SMT pass when a
solver is available.

For the original 10 programs, the Core sketch now goes one layer further than
procedure names. It includes inferred abstract axioms, preconditions,
postconditions, and derived procedures that stack an extra property on top of
the method-level contracts. For example, `DoubleCharacters_doubledLengthEven`
uses the `doubledLength` contract to expose the more annoying fact that the
computed doubled length is even, and `EvenFilterArray_evensLengthBound` stacks
the `countEvens` bound into an output-length bound for the filtered array.

## Example Chain

For `EvenFilterArray.countEvens`:

- L0 source: loop through `items`, call `isEven`, increment `count`.
- L1 surface: count even values in an array.
- L2 functional: result equals the number of indices whose values are even.
- L3 operational: after scanning prefix `items[0..i-1]`, `count` equals the
  number of even values in that prefix.
- L4 verification: loop invariant connects `count`, prefix length, and parity.
- L5 Strata Core sketch: `EvenFilterArray_countEvens` ensures
  `result == evenCount(items)`.

A later method, `EvenFilterArray.evens`, should not re-establish the counting
fact from scratch. It should use the count semantics to justify its output
length, then add its own order-preservation and membership facts.

This is the intended style throughout: semantic facts become reusable links.

## What Success Looks Like

The near-term success criterion is modest but concrete:

- The corpus compiles as Java.
- Every corpus method has a complete semantic chain.
- The Strata/Boogie-like target is generated or maintained in a readable form.
- The Strata Core target parses and type-checks against the current Strata CLI.
- The chain exposes facts that later methods can cite.
- A human can inspect the chain and see why the target theorem/spec follows
  from the previous layer.

The next stronger success criterion is to replace more of the lightweight target
stubs with concrete procedure bodies and invariants that pass full Strata
verification without relying on assumptions. After that, the project can grow
toward generated frontends and checked refinement theorems.

## Open Research Questions

- How much of L0 -> L1 can be automated from comments and simple code shape?
- How much of L1 -> L2 should be AI-assisted versus template-driven?
- What is the smallest useful Java subset that demonstrates semantic reuse?
- Should arrays and strings be modeled extensionally first, or should the first
  pass keep abstract functions such as `arrLen`, `arrRead`, and `strlen`?
- How much Boogie compatibility should be preserved versus leaning into Strata
  idioms directly?
- What is the right UI for showing a semantic chain so that non-formal-methods
  users understand why theorem proving buys something?

## Current Position

The project is currently at the structured-artifact stage. It has not yet
claimed a complete verified Java frontend. The value of the current state is
that it makes the intended chain explicit and testable: every Java method is
connected to a surface claim, a functional relation, an operational story, a
verification obligation, and a Strata Core target.
