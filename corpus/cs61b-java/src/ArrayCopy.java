/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: copying arrays without aliasing the input.
 */
public class ArrayCopy {
    /**
     * CS61B-style intent: Return a same-length array with the same values.
     * Semantic target: For every index i, result[i] = items[i].
     */
    public static int[] copy(int[] items) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            result[i] = items[i];
        }
        return result;
    }

    /**
     * CS61B-style intent: Sum a copied array.
     * Semantic target: Result equals the sum of the original values.
     */
    public static int copyAndSum(int[] items) {
        int[] copied = copy(items);
        int total = 0;
        for (int i = 0; i < copied.length; i += 1) {
            total += copied[i];
        }
        return total;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {3, 1, 4};
        System.out.println(copy(data)[1]);
        System.out.println(copyAndSum(data));
    }
}
