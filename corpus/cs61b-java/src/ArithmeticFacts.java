/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw01/src/Arithmetic.java.
 * Focus: integer arithmetic helpers and function calls.
 */
public class ArithmeticFacts {
    /**
     * CS61B-style intent: Compute the product of two integers.
     * Semantic target: result = a * b.
     */
    public static int product(int a, int b) {
        return a * b;
    }

    /**
     * CS61B-style intent: Compute the sum of two integers.
     * Semantic target: result = a + b.
     */
    public static int sum(int a, int b) {
        return a + b;
    }

    /**
     * CS61B-style intent: Multiply by base exponent times.
     * Semantic target: For exponent >= 0, result = base raised to exponent.
     */
    public static int boundedPower(int base, int exponent) {
        int result = 1;
        for (int i = 0; i < exponent; i += 1) {
            result = product(result, base);
        }
        return result;
    }

    /**
     * CS61B-style intent: Return the largest of three integers.
     * Semantic target: result is one of a, b, c and every input is <= result.
     */
    public static int maxOfThree(int a, int b, int c) {
        int best = a;
        if (b > best) {
            best = b;
        }
        if (c > best) {
            best = c;
        }
        return best;
    }

    /**
     * CS61B-style intent: Composition harness that chains sum, product, and maxOfThree.
     * Semantic target: reuse helper facts to get result = ((a + b) * c) + max(a, b, c).
     */
    public static int score(int a, int b, int c) {
        int pairTotal = sum(a, b);
        int scaled = product(pairTotal, c);
        return sum(scaled, maxOfThree(a, b, c));
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(score(2, 3, 4));
        System.out.println(boundedPower(3, 4));
    }
}

