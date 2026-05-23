/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: interleaving two equal-length arrays.
 */
public class ArrayInterleave {
    /**
     * CS61B-style intent: Alternate values from two arrays.
     * Semantic target: result[2*i] = left[i] and result[2*i+1] = right[i].
     */
    public static int[] interleave(int[] left, int[] right) {
        int[] result = new int[left.length * 2];
        for (int i = 0; i < left.length; i += 1) {
            result[2 * i] = left[i];
            result[2 * i + 1] = right[i];
        }
        return result;
    }

    /**
     * CS61B-style intent: Return the length of the interleaved output.
     * Semantic target: Result is 2 * left.length.
     */
    public static int interleavedLength(int[] left, int[] right) {
        return interleave(left, right).length;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] left = new int[] {1, 3};
        int[] right = new int[] {2, 4};
        System.out.println(interleave(left, right)[3]);
        System.out.println(interleavedLength(left, right));
    }
}
