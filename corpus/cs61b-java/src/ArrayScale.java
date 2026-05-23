/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: scaling every value in an array.
 */
public class ArrayScale {
    /**
     * CS61B-style intent: Multiply every array element by a factor.
     * Semantic target: For every index i, result[i] = items[i] * factor.
     */
    public static int[] scale(int[] items, int factor) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            result[i] = items[i] * factor;
        }
        return result;
    }

    /**
     * CS61B-style intent: Sum the scaled array.
     * Semantic target: Result is factor times the sum of input values.
     */
    public static int scaledSum(int[] items, int factor) {
        int[] scaled = scale(items, factor);
        int total = 0;
        for (int i = 0; i < scaled.length; i += 1) {
            total += scaled[i];
        }
        return total;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {2, 3, 4};
        System.out.println(scale(data, 3)[1]);
        System.out.println(scaledSum(data, 2));
    }
}
