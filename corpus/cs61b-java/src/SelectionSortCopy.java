/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw09/tests/StringUtils.java.
 * Focus: selection sort into a copied array.
 */
public class SelectionSortCopy {
    /**
     * CS61B-style intent: Return a sorted copy using selection sort.
     * Semantic target: Output is sorted and is a permutation of input.
     */
    public static int[] sortedCopy(int[] items) {
        int[] result = ArrayCopy.copy(items);
        for (int i = 0; i < result.length; i += 1) {
            int best = i;
            for (int j = i + 1; j < result.length; j += 1) {
                if (result[j] < result[best]) {
                    best = j;
                }
            }
            int temp = result[i];
            result[i] = result[best];
            result[best] = temp;
        }
        return result;
    }

    /**
     * CS61B-style intent: Return the smallest value via sortedCopy.
     * Semantic target: For nonempty input, result is the minimum input value.
     */
    public static int smallest(int[] items) {
        return sortedCopy(items)[0];
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[] data = new int[] {4, 1, 3};
        System.out.println(sortedCopy(data)[0]);
        System.out.println(smallest(data));
    }
}
