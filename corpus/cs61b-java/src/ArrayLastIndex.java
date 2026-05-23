/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp21/lab3/randomizedtest/AListNoResizing.java.
 * Focus: linear search for last index.
 */
public class ArrayLastIndex {
    /**
     * CS61B-style intent: Find the last target index or -1.
     * Semantic target: Result is the greatest matching index, or -1 if none exists.
     */
    public static int lastIndexOf(int[] items, int target) {
        int found = -1;
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] == target) {
                found = i;
            }
        }
        return found;
    }

    /**
     * CS61B-style intent: Compute the gap between first and last target occurrence.
     * Semantic target: Result is lastIndexOf(items,target) - firstIndexOf(items,target).
     */
    public static int distanceBetweenFirstAndLast(int[] items, int target) {
        int first = ArrayFirstIndex.firstIndexOf(items, target);
        int last = lastIndexOf(items, target);
        return last - first;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {4, 1, 4};
        System.out.println(lastIndexOf(data, 4));
        System.out.println(distanceBetweenFirstAndLast(data, 4));
    }
}
