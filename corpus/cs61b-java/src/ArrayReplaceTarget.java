/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: copying with target replacement.
 */
public class ArrayReplaceTarget {
    /**
     * CS61B-style intent: Replace each target value in a copy.
     * Semantic target: Each output index is replacement when input equals target, otherwise the original value.
     */
    public static int[] replace(int[] items, int target, int replacement) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] == target) {
                result[i] = replacement;
            } else {
                result[i] = items[i];
            }
        }
        return result;
    }

    /**
     * CS61B-style intent: Count replacement values after replacing.
     * Semantic target: Result counts replacement in replace(items,target,replacement).
     */
    public static int replacedCount(int[] items, int target, int replacement) {
        int[] result = replace(items, target, replacement);
        return ArrayCountTarget.countTarget(result, replacement);
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {1, 2, 1};
        System.out.println(replace(data, 1, 9)[2]);
        System.out.println(replacedCount(data, 1, 9));
    }
}
