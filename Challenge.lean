/-
Challenge module for comparator verification.

Mirrors the public API of `StrataJava/ArithmeticFacts.lean` with proof bodies
left as `sorry`. Comparator checks that the `Solution` module proves the same
statements (declaration-for-declaration, including referenced defs) using only
the permitted axioms listed in `comparator-config.json`.
-/

import Mathlib.Tactic.Ring

namespace ArithmeticFacts

def product (a b : Int) : Int := a * b

def sum (a b : Int) : Int := a + b

theorem product_summary (a b : Int) : product a b = a * b := sorry

theorem product_commutes (a b : Int) : product a b = product b a := sorry

theorem sum_summary (a b : Int) : sum a b = a + b := sorry

theorem sum_commutes (a b : Int) : sum a b = sum b a := sorry

theorem product_distrib_over_sum (a b c : Int) :
    product a (sum b c) = sum (product a b) (product a c) := sorry

end ArithmeticFacts
