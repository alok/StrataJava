/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java.
 * Focus: column sums of a rectangular matrix.
 */
public class MatrixColumnSums {
    /**
     * CS61B-style intent: Compute one sum per matrix column.
     * Semantic target: result[col] is the finite sum of matrix rows at that column.
     */
    public static int[] columnSums(int[][] matrix) {
        int[] result = new int[matrix[0].length];
        for (int col = 0; col < matrix[0].length; col += 1) {
            int total = 0;
            for (int row = 0; row < matrix.length; row += 1) {
                total += matrix[row][col];
            }
            result[col] = total;
        }
        return result;
    }

    /**
     * CS61B-style intent: Return the first column sum.
     * Semantic target: Result is sum over matrix[row][0].
     */
    public static int firstColumnSum(int[][] matrix) {
        return columnSums(matrix)[0];
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        int[][] matrix = new int[][] {{1, 2}, {3, 4}};
        System.out.println(columnSums(matrix)[1]);
        System.out.println(firstColumnSum(matrix));
    }
}
