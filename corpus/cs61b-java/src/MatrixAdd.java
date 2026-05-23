/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java.
 * Focus: pointwise matrix addition.
 */
public class MatrixAdd {
    /**
     * CS61B-style intent: Add two matrices pointwise.
     * Semantic target: result[row][col] = left[row][col] + right[row][col].
     */
    public static int[][] add(int[][] left, int[][] right) {
        int[][] result = new int[left.length][left[0].length];
        for (int row = 0; row < left.length; row += 1) {
            for (int col = 0; col < left[row].length; col += 1) {
                result[row][col] = left[row][col] + right[row][col];
            }
        }
        return result;
    }

    /**
     * CS61B-style intent: Read the top-left pointwise sum.
     * Semantic target: Result is left[0][0] + right[0][0].
     */
    public static int topLeftSum(int[][] left, int[][] right) {
        return add(left, right)[0][0];
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[][] left = new int[][] {{1, 2}, {3, 4}};
        int[][] right = new int[][] {{5, 6}, {7, 8}};
        System.out.println(add(left, right)[1][1]);
        System.out.println(topLeftSum(left, right));
    }
}
