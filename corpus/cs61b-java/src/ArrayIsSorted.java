/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw09/tests/TestBSTMap.java.
 * Focus: checking nondecreasing array order.
 */
public class ArrayIsSorted {
    /**
     * CS61B-style intent: Check nondecreasing order.
     * Semantic target: Result is true iff adjacent pairs are ordered.
     */
    public static boolean isSorted(int[] items) {
        boolean sorted = true;
        for (int i = 1; i < items.length; i += 1) {
            if (items[i] < items[i - 1]) {
                sorted = false;
            }
        }
        return sorted;
    }

    /**
     * CS61B-style intent: Score an array based on sortedness.
     * Semantic target: Result is length for sorted input and negative length otherwise.
     */
    public static int sortedScore(int[] items) {
        if (isSorted(items)) {
            return items.length;
        }
        return -items.length;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {1, 3, 3, 8};
        System.out.println(isSorted(data));
        System.out.println(sortedScore(data));
    }
}
