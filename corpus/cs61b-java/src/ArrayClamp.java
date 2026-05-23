/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: clamping values to an inclusive interval.
 */
public class ArrayClamp {
    /**
     * CS61B-style intent: Limit a value to an interval.
     * Semantic target: Result is low, high, or value depending on bounds.
     */
    public static int clampValue(int value, int low, int high) {
        if (value < low) {
            return low;
        }
        if (value > high) {
            return high;
        }
        return value;
    }

    /**
     * CS61B-style intent: Clamp every array element.
     * Semantic target: result[i] = clampValue(items[i], low, high).
     */
    public static int[] clampAll(int[] items, int low, int high) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            result[i] = clampValue(items[i], low, high);
        }
        return result;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {-1, 5, 99};
        System.out.println(clampValue(12, 0, 10));
        System.out.println(clampAll(data, 0, 10)[2]);
    }
}
