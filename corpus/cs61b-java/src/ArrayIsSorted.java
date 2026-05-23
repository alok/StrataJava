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
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {1, 3, 3, 8};
        System.out.println(isSorted(data));
    }
}
