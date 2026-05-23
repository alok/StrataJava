/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp21/lab1/HelloNumbers.java.
 * Focus: factorial by bounded multiplication.
 */
public class NumberFactorialBounded {
    /**
     * CS61B-style intent: Compute n factorial for nonnegative n.
     * Semantic target: Result is the product of integers 2..n.
     */
    public static int factorial(int n) {
        int result = 1;
        for (int i = 2; i <= n; i += 1) {
            result *= i;
        }
        return result;
    }

    /**
     * CS61B-style intent: Add one to factorial.
     * Semantic target: Result is factorial(n) + 1.
     */
    public static int factorialPlusOne(int n) {
        return factorial(n) + 1;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(factorial(5));
        System.out.println(factorialPlusOne(4));
    }
}
