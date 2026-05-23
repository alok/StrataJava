/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: pairwise adjacent differences.
 */
public class ArrayPairwiseDiff {
    /**
     * CS61B-style intent: Return adjacent differences.
     * Semantic target: result[i] = items[i + 1] - items[i].
     */
    public static int[] differences(int[] items) {
        int[] result = new int[items.length - 1];
        for (int i = 0; i < result.length; i += 1) {
            result[i] = items[i + 1] - items[i];
        }
        return result;
    }

    /**
     * CS61B-style intent: Return the first adjacent difference.
     * Semantic target: Result is items[1] - items[0].
     */
    public static int firstDifference(int[] items) {
        return differences(items)[0];
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {3, 8, 10};
        System.out.println(differences(data)[1]);
        System.out.println(firstDifference(data));
    }
}
