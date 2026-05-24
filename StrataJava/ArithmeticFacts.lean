-- Formal Lean encoding of ArithmeticFacts.java.
--
-- Pipeline: Java source → Strata Core sketch → Lean.
-- Each definition mirrors the Java method; each theorem proves the
-- corresponding postcondition from the ArithmeticFacts_* Core procedures.
-- Only Lean 4 core (Init) lemmas — no Mathlib.

namespace ArithmeticFacts

-- ──────────────────────────────────────────────────────────────
-- Definitions  (Java → Lean translation)
-- ──────────────────────────────────────────────────────────────

def product (a b : Int) : Int := a * b

def sum (a b : Int) : Int := a + b

-- Two sequential conditional updates: best starts at a, then is
-- bumped to b if b is larger, then bumped to c if c is larger.
def maxOfThree (a b c : Int) : Int :=
  let best₂ := if b > a then b else a
  if c > best₂ then c else best₂

-- Loop "result := result * base" executed exponent times.
-- Nat exponent encodes the Java precondition exponent >= 0.
def boundedPower (base : Int) : Nat → Int
  | 0     => 1
  | n + 1 => product (boundedPower base n) base

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
-- maxOfThree postconditions
-- Core: a <= result; b <= result; c <= result;
--       result ∈ {a,b,c}; a==b==c => result==a
-- ──────────────────────────────────────────────────────────────

theorem maxOfThree_upper_a (a b c : Int) : a ≤ maxOfThree a b c := by
  simp only [maxOfThree]
  by_cases h1 : b > a <;> by_cases h2 : c > (if b > a then b else a)
  all_goals simp_all
  all_goals omega

theorem maxOfThree_upper_b (a b c : Int) : b ≤ maxOfThree a b c := by
  simp only [maxOfThree]
  by_cases h1 : b > a <;> by_cases h2 : c > (if b > a then b else a)
  all_goals simp_all
  all_goals omega

theorem maxOfThree_upper_c (a b c : Int) : c ≤ maxOfThree a b c := by
  simp only [maxOfThree]
  by_cases h1 : b > a <;> by_cases h2 : c > (if b > a then b else a)
  all_goals simp_all
  all_goals omega

-- The result is always one of the three inputs.
theorem maxOfThree_member (a b c : Int) :
    maxOfThree a b c = a ∨ maxOfThree a b c = b ∨ maxOfThree a b c = c := by
  simp only [maxOfThree]
  by_cases h1 : b > a <;> by_cases h2 : c > (if b > a then b else a)
  all_goals simp_all
  all_goals omega

theorem maxOfThree_idempotent (a : Int) : maxOfThree a a a = a := by
  simp only [maxOfThree]
  have h : ¬ (a > a) := by omega
  simp [h]

-- ──────────────────────────────────────────────────────────────
-- boundedPower postconditions
-- Core: exponent == 0 => result == 1;
--       exponent == 1 => result == base;
--       result == base ^ exponent  (loop invariant)
-- ──────────────────────────────────────────────────────────────

theorem boundedPower_zero (base : Int) : boundedPower base 0 = 1 := rfl

-- Explicit step lemma matching the loop body: result := result * base.
theorem boundedPower_step (base : Int) (n : Nat) :
    boundedPower base (n + 1) = boundedPower base n * base := by
  simp [boundedPower, product]

theorem boundedPower_one (base : Int) : boundedPower base 1 = base := by
  simp [boundedPower, product]

-- Loop invariant: after n iterations, result = base ^ n.
-- Proof by induction on n, using Int.pow_succ for the step.
theorem boundedPower_correct (base : Int) (n : Nat) : boundedPower base n = base ^ n := by
  induction n with
  | zero      => simp [boundedPower]
  | succ n ih => rw [boundedPower_step, ih, Int.pow_succ]

-- ──────────────────────────────────────────────────────────────
-- Derived / stacked properties
-- ──────────────────────────────────────────────────────────────

-- boundedPower of a nonneg base is nonneg (inductive, mirrors the loop).
theorem boundedPower_nonneg {base : Int} (hb : 0 ≤ base) : ∀ n : Nat, 0 ≤ boundedPower base n
  | 0     => by simp [boundedPower]
  | n + 1 => by rw [boundedPower_step]; exact Int.mul_nonneg (boundedPower_nonneg hb n) hb

-- product of two nonneg integers is nonneg.
theorem product_nonneg {a b : Int} (ha : 0 ≤ a) (hb : 0 ≤ b) : 0 ≤ product a b := by
  unfold product; exact Int.mul_nonneg ha hb

end ArithmeticFacts
