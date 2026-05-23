/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java.
 * Focus: filtering integer sequences.
 */
public class EvenFilterArray {
    /**
     * CS61B-style intent: Test divisibility by two.
     * Semantic target: result is true iff value mod 2 = 0.
     */
    public static boolean isEven(int value) {
        return value % 2 == 0;
    }

    /**
     * CS61B-style intent: Count even values in an array.
     * Semantic target: result equals the number of indices i where items[i] is even.
     */
    public static int countEvens(int[] items) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isEven(items[i])) {
                count += 1;
            }
        }
        return count;
    }

    /**
     * CS61B-style intent: Return a new array containing exactly the even values in order.
     * Semantic target: Output length is countEvens(items), every output item is even, and order is inherited from input.
     */
    public static int[] evens(int[] items) {
        int[] result = new int[countEvens(items)];
        int outputIndex = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isEven(items[i])) {
                result[outputIndex] = items[i];
                outputIndex += 1;
            }
        }
        return result;
    }

    /**
     * CS61B-style intent: Sum all integers in an array.
     * Semantic target: result is the finite sum of all array elements.
     */
    public static int sum(int[] items) {
        int total = 0;
        for (int i = 0; i < items.length; i += 1) {
            total += items[i];
        }
        return total;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {1, 2, 3, 4, 5, 6};
        System.out.println(countEvens(data));
        System.out.println(sum(evens(data)));
    }
}

