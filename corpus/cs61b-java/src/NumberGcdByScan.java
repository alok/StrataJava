/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp21/lab2/IntList/Primes.java.
 * Focus: greatest common divisor by bounded scan.
 */
public class NumberGcdByScan {
    /**
     * CS61B-style intent: Find the greatest common divisor by scanning candidates.
     * Semantic target: Result is the largest d <= min(a,b) dividing both inputs.
     */
    public static int gcdByScan(int a, int b) {
        int limit = a;
        if (b < limit) {
            limit = b;
        }
        int best = 1;
        for (int d = 1; d <= limit; d += 1) {
            if (a % d == 0 && b % d == 0) {
                best = d;
            }
        }
        return best;
    }

    /**
     * CS61B-style intent: Check whether gcd is one.
     * Semantic target: Result is true iff gcdByScan(a,b) == 1.
     */
    public static boolean relativelyPrime(int a, int b) {
        return gcdByScan(a, b) == 1;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(gcdByScan(12, 18));
        System.out.println(relativelyPrime(8, 15));
    }
}
