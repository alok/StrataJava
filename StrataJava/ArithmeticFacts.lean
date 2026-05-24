-- Formal Lean encoding of ArithmeticFacts.java.
--
-- Pipeline: Java source → Strata Core sketch → Lean.
-- Each definition mirrors the Java method; each theorem proves the
-- corresponding postcondition from the ArithmeticFacts_* Core procedures.
-- We use Mathlib for off-the-shelf `Int.mul_comm`, `Int.add_comm`, and
-- `Int.mul_add` so every theorem below only depends on the three core Lean
-- axioms (`propext`, `Classical.choice`, `Quot.sound`).

import Mathlib.Tactic.Ring

namespace ArithmeticFacts

-- ──────────────────────────────────────────────────────────────
-- Definitions  (Java → Lean translation)
-- ──────────────────────────────────────────────────────────────

def product (a b : Int) : Int := a * b

def sum (a b : Int) : Int := a + b

-- ──────────────────────────────────────────────────────────────
-- product postconditions
-- Core: ensures result == a * b; ensures result == b * a
-- ──────────────────────────────────────────────────────────────

theorem product_summary (a b : Int) : product a b = a * b := rfl

theorem product_commutes (a b : Int) : product a b = product b a := by
  unfold product; exact Int.mul_comm a b

-- ──────────────────────────────────────────────────────────────
-- sum postconditions
-- Core: ensures result == a + b; ensures result == b + a
-- ──────────────────────────────────────────────────────────────

theorem sum_summary (a b : Int) : sum a b = a + b := rfl

theorem sum_commutes (a b : Int) : sum a b = sum b a := by
  unfold sum; exact Int.add_comm a b

-- ──────────────────────────────────────────────────────────────
-- Stacked property: distributivity of product over sum
-- Core: ArithmeticFacts_product_distrib_over_sum.
--
-- The headline obligation: it cannot be discharged from the product
-- specs alone, nor from the sum specs alone. The proof rewrites with
-- both summary lemmas (product_summary and sum_summary) and then uses
-- `Int.mul_add`. This demonstrates Lean's ability to reuse semantic
-- facts from different functions as theorem inputs.
-- ──────────────────────────────────────────────────────────────

theorem product_distrib_over_sum (a b c : Int) :
    product a (sum b c) = sum (product a b) (product a c) := by
  -- Combine the spec of `sum` and the spec of `product` (twice), then
  -- discharge the residual ring identity. This is the version that makes
  -- the cross-function stacking explicit: it does not type-check if you
  -- omit either rewrite set.
  rw [sum_summary, product_summary, product_summary, product_summary, sum_summary]
  ring

-- ──────────────────────────────────────────────────────────────
-- Axiom audit: every theorem above should only depend on the three
-- core Lean axioms (`propext`, `Classical.choice`, `Quot.sound`).
-- Run `lake env lean StrataJava/ArithmeticFacts.lean` to inspect.
-- ──────────────────────────────────────────────────────────────

#print axioms product_summary
#print axioms product_commutes
#print axioms sum_summary
#print axioms sum_commutes
#print axioms product_distrib_over_sum

end ArithmeticFacts
