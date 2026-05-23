/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java.
 * Focus: counting zero values in an array.
 */
public class ArrayZeroCount {
    /**
     * CS61B-style intent: Test whether a number is zero.
     * Semantic target: Result is true iff value == 0.
     */
    public static boolean isZero(int value) {
        return value == 0;
    }

    /**
     * CS61B-style intent: Count zero array values.
     * Semantic target: Result is the number of zero entries.
     */
    public static int countZero(int[] items) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isZero(items[i])) {
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
        int[] data = new int[] {0, 5, 0, 7};
        System.out.println(countZero(data));
    }
}
