/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java.
 * Focus: counting negative values in an array.
 */
public class ArrayNegativeCount {
    /**
     * CS61B-style intent: Test whether a number is negative.
     * Semantic target: Result is true iff value < 0.
     */
    public static boolean isNegative(int value) {
        return value < 0;
    }

    /**
     * CS61B-style intent: Count negative array values.
     * Semantic target: Result is the number of indices containing negative values.
     */
    public static int countNegative(int[] items) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isNegative(items[i])) {
                count += 1;
            }
        }
        return count;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {-2, 5, -3, 7};
        System.out.println(countNegative(data));
    }
}
