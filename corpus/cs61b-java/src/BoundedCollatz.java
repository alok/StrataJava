/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp21 lab1/Collatz.java.
 * Focus: branch-heavy numeric transition with explicit step bound.
 */
public class BoundedCollatz {
    /**
     * CS61B-style intent: Compute the next Collatz value.
     * Semantic target: If n is even, result = n / 2; otherwise result = 3*n + 1.
     */
    public static int nextNumber(int n) {
        if (n % 2 == 0) {
            return n / 2;
        }
        return 3 * n + 1;
    }

    /**
     * CS61B-style intent: Run Collatz until one or until fuel is exhausted.
     * Semantic target: For maxSteps >= 0, result is the first k <= maxSteps such that iter(start, k) = 1, or maxSteps if none is reached earlier.
     */
    public static int stepsUntilOne(int start, int maxSteps) {
        int value = start;
        int steps = 0;
        for (int i = 0; i < maxSteps; i += 1) {
            if (value == 1) {
                return steps;
            }
            value = nextNumber(value);
            steps += 1;
        }
        return steps;
    }

    /**
     * CS61B-style intent: Return the Collatz value after bounded fuel or after reaching one.
     * Semantic target: For maxSteps >= 0, result = iter(start, k) where k is min(maxSteps, first step reaching one).
     */
    public static int valueAfterSteps(int start, int maxSteps) {
        int value = start;
        for (int i = 0; i < maxSteps; i += 1) {
            if (value == 1) {
                return value;
            }
            value = nextNumber(value);
        }
        return value;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(stepsUntilOne(7, 20));
        System.out.println(valueAfterSteps(7, 5));
    }
}

