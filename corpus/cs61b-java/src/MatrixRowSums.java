/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java.
 * Focus: row sums of a rectangular matrix.
 */
public class MatrixRowSums {
    /**
     * CS61B-style intent: Compute one sum per matrix row.
     * Semantic target: result[row] is the finite sum of matrix[row].
     */
    public static int[] rowSums(int[][] matrix) {
        int[] result = new int[matrix.length];
        for (int row = 0; row < matrix.length; row += 1) {
            int total = 0;
            for (int col = 0; col < matrix[row].length; col += 1) {
                total += matrix[row][col];
            }
            result[row] = total;
        }
        return result;
    }

    /**
     * CS61B-style intent: Return the first row sum.
     * Semantic target: Result is sum(matrix[0]).
     */
    public static int firstRowSum(int[][] matrix) {
        return rowSums(matrix)[0];
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[][] matrix = new int[][] {{1, 2}, {3, 4}};
        System.out.println(rowSums(matrix)[1]);
        System.out.println(firstRowSum(matrix));
    }
}
