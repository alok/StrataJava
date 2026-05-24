/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw01/src/Arithmetic.java.
 * Focus: integer arithmetic helpers, stripped to the two operations we verify
 * downstream — product and sum — so we can prove commutativity of each and
 * distributivity of product over sum in Lean.
 */
public class ArithmeticFacts {
    /**
     * CS61B-style intent: Compute the product of two integers.
     * Semantic target: result = a * b.
     */
    public static int product(int a, int b) { // human-checked
        return a * b;
    }

    /**
     * CS61B-style intent: Compute the sum of two integers.
     * Semantic target: result = a + b.
     */
    public static int sum(int a, int b) { // human-checked
        return a + b;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(product(3, 4));
        System.out.println(sum(3, 4));
        // Distributivity witness: a*(b+c) vs a*b + a*c.
        System.out.println(product(2, sum(3, 4)));
        System.out.println(sum(product(2, 3), product(2, 4)));
    }
}
