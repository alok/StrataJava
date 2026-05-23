/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: prefix sums over an integer array.
 */
public class ArrayPrefixSums {
    /**
     * CS61B-style intent: Return running totals.
     * Semantic target: result[i] equals the sum of items[0..i].
     */
    public static int[] prefixSums(int[] items) {
        int[] result = new int[items.length];
        int total = 0;
        for (int i = 0; i < items.length; i += 1) {
            total += items[i];
            result[i] = total;
        }
        return result;
    }

    /**
     * CS61B-style intent: Return the last prefix sum.
     * Semantic target: For nonempty input, result is the sum of all items.
     */
    public static int finalPrefix(int[] items) {
        int[] sums = prefixSums(items);
        return sums[sums.length - 1];
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {1, 2, 3};
        System.out.println(prefixSums(data)[2]);
        System.out.println(finalPrefix(data));
    }
}
