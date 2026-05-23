/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java.
 * Focus: counting positive values in an array.
 */
public class ArrayPositiveCount {
    /**
     * CS61B-style intent: Test whether a number is positive.
     * Semantic target: Result is true iff value > 0.
     */
    public static boolean isPositive(int value) {
        return value > 0;
    }

    /**
     * CS61B-style intent: Count positive array values.
     * Semantic target: Result is the number of indices containing positive values.
     */
    public static int countPositive(int[] items) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isPositive(items[i])) {
                count += 1;
            }
        }
        return count;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {-2, 5, 0, 7};
        System.out.println(countPositive(data));
    }
}
