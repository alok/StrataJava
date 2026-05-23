/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: left rotation of an integer array.
 */
public class ArrayRotateLeft {
    /**
     * CS61B-style intent: Move every element one position left and wrap the first value to the end.
     * Semantic target: For nonempty input, result[i] = items[i + 1] except the last result is items[0].
     */
    public static int[] rotateLeftOne(int[] items) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            if (i + 1 < items.length) {
                result[i] = items[i + 1];
            } else {
                result[i] = items[0];
            }
        }
        return result;
    }

    /**
     * CS61B-style intent: Return the first value after a left rotation.
     * Semantic target: For length > 1, result is items[1].
     */
    public static int rotatedFirst(int[] items) {
        return rotateLeftOne(items)[0];
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {9, 8, 7};
        System.out.println(rotateLeftOne(data)[2]);
        System.out.println(rotatedFirst(data));
    }
}
