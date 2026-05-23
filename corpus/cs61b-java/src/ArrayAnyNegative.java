/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java.
 * Focus: existential negativity check.
 */
public class ArrayAnyNegative {
    /**
     * CS61B-style intent: Check whether any item is negative.
     * Semantic target: Result is true iff at least one entry is less than zero.
     */
    public static boolean anyNegative(int[] items) {
        boolean found = false;
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] < 0) {
                found = true;
            }
        }
        return found;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {1, -2, 3};
        System.out.println(anyNegative(data));
    }
}
