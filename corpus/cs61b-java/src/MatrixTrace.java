public class MatrixTrace {
    public static int trace(int[][] matrix) {
        int total = 0;
        for (int i = 0; i < matrix.length; i += 1) {
            total += matrix[i][i];
        }
        return total;
    }

    public static int tracePlusSize(int[][] matrix) {
        return trace(matrix) + matrix.length;
    }

    public static void main(String[] args) {
        int[][] matrix = new int[][] {{1, 2}, {3, 4}};
        System.out.println(trace(matrix));
        System.out.println(tracePlusSize(matrix));
    }
}
