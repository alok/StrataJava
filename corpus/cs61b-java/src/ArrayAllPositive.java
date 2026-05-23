/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java.
 * Focus: universal positivity check.
 */
public class ArrayAllPositive {
    /**
     * CS61B-style intent: Check that every item is positive.
     * Semantic target: Result is true iff all entries are greater than zero.
     */
    public static boolean allPositive(int[] items) {
        boolean ok = true;
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] <= 0) {
                ok = false;
            }
        }
        return ok;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {1, 2, 3};
        System.out.println(allPositive(data));
    }
}
