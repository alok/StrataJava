/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java.
 * Focus: common values in two sequences.
 */
public class CommonValuesArray {
    /**
     * CS61B-style intent: Check whether target appears before a limit.
     * Semantic target: result is true iff some index i with 0 <= i < limit has items[i] == target.
     */
    public static boolean containsBefore(int[] items, int limit, int target) {
        for (int i = 0; i < limit; i += 1) {
            if (items[i] == target) {
                return true;
            }
        }
        return false;
    }

    /**
     * CS61B-style intent: Count distinct values from left that also appear in right.
     * Semantic target: result is the cardinality of set(left) intersect set(right).
     */
    public static int countCommonDistinct(int[] left, int[] right) {
        int count = 0;
        int[] seen = new int[left.length];
        for (int i = 0; i < left.length; i += 1) {
            if (!containsBefore(seen, count, left[i]) && contains(right, left[i])) {
                seen[count] = left[i];
                count += 1;
            }
        }
        return count;
    }

    /**
     * CS61B-style intent: Check whether target appears anywhere in the array.
     * Semantic target: result is true iff some valid array index contains target.
     */
    public static boolean contains(int[] items, int target) {
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] == target) {
                return true;
            }
        }
        return false;
    }

    /**
     * CS61B-style intent: Return distinct common values in the order first seen in left.
     * Semantic target: Output contains each value in set(left) intersect set(right) exactly once, ordered by first occurrence in left.
     */
    public static int[] commonDistinct(int[] left, int[] right) {
        int count = countCommonDistinct(left, right);
        int[] result = new int[count];
        int used = 0;
        for (int i = 0; i < left.length; i += 1) {
            if (!containsBefore(result, used, left[i]) && contains(right, left[i])) {
                result[used] = left[i];
                used += 1;
            }
        }
        return result;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] left = new int[] {4, 1, 4, 2, 8};
        int[] right = new int[] {2, 4, 9};
        int[] result = commonDistinct(left, right);
        for (int i = 0; i < result.length; i += 1) {
            System.out.println(result[i]);
        }
    }
}

