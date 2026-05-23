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
     * CS61B-style intent: Return a penalty when a negative exists.
     * Semantic target: Result is -1 iff anyNegative(items), otherwise zero.
     */
    public static int negativePenalty(int[] items) {
        if (anyNegative(items)) {
            return -1;
        }
        return 0;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {1, -2, 3};
        System.out.println(anyNegative(data));
        System.out.println(negativePenalty(data));
    }
}
