/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java.
 * Focus: array scan for minimum and maximum.
 */
public class ArrayMinMax {
    /**
     * CS61B-style intent: Return the minimum item in a nonempty array.
     * Semantic target: result is an element of items and every array element is >= result.
     */
    public static int minValue(int[] items) {
        int best = items[0];
        for (int i = 1; i < items.length; i += 1) {
            if (items[i] < best) {
                best = items[i];
            }
        }
        return best;
    }

    /**
     * CS61B-style intent: Return the maximum item in a nonempty array.
     * Semantic target: result is an element of items and every array element is <= result.
     */
    public static int maxValue(int[] items) {
        int best = items[0];
        for (int i = 1; i < items.length; i += 1) {
            if (items[i] > best) {
                best = items[i];
            }
        }
        return best;
    }

    /**
     * CS61B-style intent: Return the spread between maximum and minimum.
     * Semantic target: result = max(items) - min(items).
     */
    public static int minMaxDifference(int[] items) {
        return maxValue(items) - minValue(items);
    }

    /**
     * CS61B-style intent: Return the second largest value among exactly the first four items.
     * Semantic target: result is the largest value after removing one occurrence of the maximum from items[0..3].
     */
    public static int secondLargestOfFour(int[] items) {
        int largest = items[0];
        int second = items[1];
        if (second > largest) {
            int oldLargest = largest;
            largest = second;
            second = oldLargest;
        }
        for (int i = 2; i < 4; i += 1) {
            if (items[i] > largest) {
                second = largest;
                largest = items[i];
            } else if (items[i] > second) {
                second = items[i];
            }
        }
        return second;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[] data = new int[] {7, 2, 9, 4};
        System.out.println(minMaxDifference(data));
        System.out.println(secondLargestOfFour(data));
    }
}

