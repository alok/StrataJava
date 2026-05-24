program Core;

// Semantic sketch for the trimmed StrataJava corpus.
// L5 of the semantic chain for ArithmeticFacts.java (the only corpus file).
// Java source -> surface summary -> functional relation -> operational story
// -> verification obligations -> these named Core procedure/spec targets.

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

// ── distributivity composition ────────────────────────────────
// Derived obligation that exercises both procedures at once:
// product(a, sum(b, c)) == sum(product(a, b), product(a, c)).
// This is the stacked claim — it consumes both product_summary and
// sum_summary specs, so it cannot be discharged by either alone.

procedure ArithmeticFacts_product_distrib_over_sum(a: int, b: int, c: int,
    out lhs: int, out rhs: int)
spec {
  ensures [product_distrib_over_sum]: lhs == rhs;
}
{
  lhs := a * (b + c);
  rhs := a * b + a * c;
};
