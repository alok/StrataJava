/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp21/lab2/IntList/Primes.java.
 * Focus: counting positive divisors.
 */
public class NumberDivisorCount {
    /**
     * CS61B-style intent: Count positive divisors up to n.
     * Semantic target: Result is the number of d in 1..n such that d divides n.
     */
    public static int divisorCount(int n) {
        int count = 0;
        for (int d = 1; d <= n; d += 1) {
            if (n % d == 0) {
                count += 1;
            }
        }
        return count;
    }

    /**
     * CS61B-style intent: Check whether exactly two divisors exist.
     * Semantic target: Result is true iff divisorCount(n) is two.
     */
    public static boolean hasTwoDivisors(int n) {
        return divisorCount(n) == 2;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(divisorCount(12));
        System.out.println(hasTwoDivisors(13));
    }
}
