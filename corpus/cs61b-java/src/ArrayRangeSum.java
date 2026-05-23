/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: bounded range sum over an integer array.
 */
public class ArrayRangeSum {
    /**
     * CS61B-style intent: Sum a half-open array range.
     * Semantic target: Result is the finite sum of items[start..end-1].
     */
    public static int sumRange(int[] items, int start, int end) {
        int total = 0;
        for (int i = start; i < end; i += 1) {
            total += items[i];
        }
        return total;
    }

    /**
     * CS61B-style intent: Sum a whole array by delegating to sumRange.
     * Semantic target: Result is the finite sum of all array elements.
     */
    public static int sumAll(int[] items) {
        return sumRange(items, 0, items.length);
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {2, 4, 6, 8};
        System.out.println(sumRange(data, 1, 3));
        System.out.println(sumAll(data));
    }
}
