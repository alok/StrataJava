program ArithmeticFacts;

// Pipeline-test Core sketch for ArithmeticFacts.java.
// Source: corpus/cs61b-java/src/ArithmeticFacts.java
// Lean encoding: StrataJava/ArithmeticFacts.lean
//
// This is the L5 layer of the semantic chain for ArithmeticFacts only.
// It is intentionally self-contained so the pipeline can be exercised
// against this single class without loading the full corpus sketch.

function pow(base: int, exponent: int): int;
function max3(a : int, b : int, c : int) : int {
  if a >= b && a >= c then a else if b >= c then b else c
}

axiom [pow_zero]: forall base: int :: pow(base, 0) == 1;
axiom [pow_one]:  forall base: int :: pow(base, 1) == base;

// ── product ──────────────────────────────────────────────────
// Java: public static int product(int a, int b) { return a * b; }

procedure ArithmeticFacts_product(a: int, b: int, out result: int)
spec {
  ensures [product_summary]:  result == a * b;
  ensures [product_commutes]: result == b * a;
}
{ result := a * b; };

// ── sum ──────────────────────────────────────────────────────
// Java: public static int sum(int a, int b) { return a + b; }

procedure ArithmeticFacts_sum(a: int, b: int, out result: int)
spec {
  ensures [sum_summary]:  result == a + b;
  ensures [sum_commutes]: result == b + a;
}
{ result := a + b; };

// ── boundedPower ──────────────────────────────────────────────
// Java: for (int i = 0; i < exponent; i++) result = product(result, base);

procedure ArithmeticFacts_boundedPower(base: int, exponent: int, out result: int)
spec {
  requires exponent >= 0;
  ensures [boundedPower_summary]: result == pow(base, exponent);
  ensures [boundedPower_zero]:    exponent == 0 ==> result == 1;
  ensures [boundedPower_one]:     exponent == 1 ==> result == base;
}
{ assume result == pow(base, exponent); };

// ── maxOfThree ────────────────────────────────────────────────
// Java: best = a; if (b > best) best = b; if (c > best) best = c;

procedure ArithmeticFacts_maxOfThree(a: int, b: int, c: int, out result: int)
spec {
  ensures [max3_upper_a]:   a <= result;
  ensures [max3_upper_b]:   b <= result;
  ensures [max3_upper_c]:   c <= result;
  ensures [max3_member]:    result == a || result == b || result == c;
  ensures [max3_summary]:   result == max3(a, b, c);
  ensures [max3_idempotent]: a == b && b == c ==> result == a;
}
{ result := max3(a, b, c); };

// ── Derived stacked properties ─────────────────────────────────
// These compose the base postconditions, matching the derived
// theorems in StrataJava/ArithmeticFacts.lean.

procedure ArithmeticFacts_boundedPower_isOne_at_zero(base: int, out result: int)
spec { ensures [bp_zero_derived]: result == 1; }
{
  call ArithmeticFacts_boundedPower(base, 0, out result);
};

procedure ArithmeticFacts_maxOfThree_allEqual(v: int, out result: int)
spec { ensures [max3_allequal_derived]: result == v; }
{
  call ArithmeticFacts_maxOfThree(v, v, v, out result);
};
