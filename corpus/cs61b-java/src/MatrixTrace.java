/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java.
 * Focus: trace of a square matrix.
 */
public class MatrixTrace {
    /**
     * CS61B-style intent: Sum the diagonal entries.
     * Semantic target: Result is sum(matrix[i][i]).
     */
    public static int trace(int[][] matrix) {
        int total = 0;
        for (int i = 0; i < matrix.length; i += 1) {
            total += matrix[i][i];
        }
        return total;
    }

    /**
     * CS61B-style intent: Add matrix size to its trace.
     * Semantic target: Result is trace(matrix) + matrix.length.
     */
    public static int tracePlusSize(int[][] matrix) {
        return trace(matrix) + matrix.length;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        int[][] matrix = new int[][] {{1, 2}, {3, 4}};
        System.out.println(trace(matrix));
        System.out.println(tracePlusSize(matrix));
    }
}
