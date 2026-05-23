/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp21/lab1/HelloNumbers.java.
 * Focus: iterative Fibonacci computation.
 */
public class NumberFibonacciBounded {
    /**
     * CS61B-style intent: Compute the nth Fibonacci number iteratively.
     * Semantic target: For n >= 0, result is Fib(n).
     */
    public static int fibonacci(int n) {
        int previous = 0;
        int current = 1;
        for (int i = 0; i < n; i += 1) {
            int next = previous + current;
            previous = current;
            current = next;
        }
        return previous;
    }

    /**
     * CS61B-style intent: Check parity of Fibonacci output.
     * Semantic target: Result is true iff fibonacci(n) is even.
     */
    public static boolean fibonacciIsEven(int n) {
        return fibonacci(n) % 2 == 0;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(fibonacci(7));
        System.out.println(fibonacciIsEven(6));
    }
}
