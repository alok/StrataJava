/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java.
 * Focus: maximum value in a matrix.
 */
public class MatrixMax {
    /**
     * CS61B-style intent: Find the maximum matrix value.
     * Semantic target: Result is an entry greater than or equal to every entry.
     */
    public static int max(int[][] matrix) {
        int best = matrix[0][0];
        for (int row = 0; row < matrix.length; row += 1) {
            for (int col = 0; col < matrix[row].length; col += 1) {
                if (matrix[row][col] > best) {
                    best = matrix[row][col];
                }
            }
        }
        return best;
    }

    /**
     * CS61B-style intent: Check whether the first cell is maximal.
     * Semantic target: Result is true iff matrix[0][0] equals max(matrix).
     */
    public static boolean firstIsMax(int[][] matrix) {
        return matrix[0][0] == max(matrix);
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[][] matrix = new int[][] {{1, 9}, {3, 4}};
        System.out.println(max(matrix));
        System.out.println(firstIsMax(matrix));
    }
}
