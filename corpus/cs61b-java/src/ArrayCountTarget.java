/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java.
 * Focus: counting target occurrences.
 */
public class ArrayCountTarget {
    /**
     * CS61B-style intent: Count target occurrences.
     * Semantic target: Result is the number of indices equal to target.
     */
    public static int countTarget(int[] items, int target) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] == target) {
                count += 1;
            }
        }
        return count;
    }

    /**
     * CS61B-style intent: Check whether target appears once.
     * Semantic target: Result is true iff countTarget is one.
     */
    public static boolean appearsExactlyOnce(int[] items, int target) {
        return countTarget(items, target) == 1;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {2, 2, 5};
        System.out.println(countTarget(data, 2));
        System.out.println(appearsExactlyOnce(data, 5));
    }
}
