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
     * CS61B-style intent: Return length when all values are positive.
     * Semantic target: Result is items.length iff allPositive(items), otherwise zero.
     */
    public static int positiveBonus(int[] items) {
        if (allPositive(items)) {
            return items.length;
        }
        return 0;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {1, 2, 3};
        System.out.println(allPositive(data));
        System.out.println(positiveBonus(data));
    }
}
