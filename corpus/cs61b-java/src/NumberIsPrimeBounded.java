/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp21/lab2/IntList/Primes.java.
 * Focus: bounded primality check by trial division.
 */
public class NumberIsPrimeBounded {
    /**
     * CS61B-style intent: Check whether n is prime by bounded trial division.
     * Semantic target: Result is true iff n >= 2 and no divisor d in 2..n-1 divides n.
     */
    public static boolean isPrime(int n) {
        boolean prime = n >= 2;
        for (int d = 2; d < n; d += 1) {
            if (n % d == 0) {
                prime = false;
            }
        }
        return prime;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(isPrime(13));
        System.out.println(isPrime(12));
    }
}
