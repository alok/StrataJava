/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: reversing an array into a new output.
 */
public class ArrayReverseCopy {
    /**
     * CS61B-style intent: Return a reversed copy of the input.
     * Semantic target: For every index i, result[i] = items[length - i - 1].
     */
    public static int[] reverseCopy(int[] items) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            result[i] = items[items.length - i - 1];
        }
        return result;
    }

    /**
     * CS61B-style intent: Read the first item of the reversed copy.
     * Semantic target: For nonempty input, result is the last input element.
     */
    public static int firstAfterReverse(int[] items) {
        return reverseCopy(items)[0];
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {2, 4, 6};
        System.out.println(reverseCopy(data)[0]);
        System.out.println(firstAfterReverse(data));
    }
}
