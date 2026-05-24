/-
Solution module for comparator verification.

Statement-for-statement match with `Challenge.lean`; proofs are filled in.
Together with `Challenge.lean` this drives the comparator end of the L0→L5
semantic chain: the Strata Core sketch's distributivity obligation gets
discharged here in Lean and machine-checked by comparator under a constrained
axiom set.
-/

import Mathlib.Tactic.Ring

namespace ArithmeticFacts

def product (a b : Int) : Int := a * b

def sum (a b : Int) : Int := a + b

theorem product_summary (a b : Int) : product a b = a * b := rfl

theorem product_commutes (a b : Int) : product a b = product b a := by
  unfold product; exact Int.mul_comm a b

theorem sum_summary (a b : Int) : sum a b = a + b := rfl

theorem sum_commutes (a b : Int) : sum a b = sum b a := by
  unfold sum; exact Int.add_comm a b

theorem product_distrib_over_sum (a b c : Int) :
    product a (sum b c) = sum (product a b) (product a c) := by
  rw [sum_summary, product_summary, product_summary, product_summary, sum_summary]
  ring

end ArithmeticFacts
