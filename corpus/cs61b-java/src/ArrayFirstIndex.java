/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp21/lab3/randomizedtest/AListNoResizing.java.
 * Focus: linear search for first index.
 */
public class ArrayFirstIndex {
    /**
     * CS61B-style intent: Find the first target index or -1.
     * Semantic target: Result is the least matching index, or -1 if none exists.
     */
    public static int firstIndexOf(int[] items, int target) {
        int found = -1;
        for (int i = 0; i < items.length; i += 1) {
            if (found == -1 && items[i] == target) {
                found = i;
            }
        }
        return found;
    }

    /**
     * CS61B-style intent: Check membership using firstIndexOf.
     * Semantic target: Result is true iff firstIndexOf returns a nonnegative index.
     */
    public static boolean contains(int[] items, int target) {
        return firstIndexOf(items, target) >= 0;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {4, 1, 4};
        System.out.println(firstIndexOf(data, 4));
        System.out.println(contains(data, 9));
    }
}
