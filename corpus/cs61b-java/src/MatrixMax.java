public class MatrixMax {
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

    public static boolean firstIsMax(int[][] matrix) {
        return matrix[0][0] == max(matrix);
    }

    public static void main(String[] args) {
        int[][] matrix = new int[][] {{1, 9}, {3, 4}};
        System.out.println(max(matrix));
        System.out.println(firstIsMax(matrix));
    }
}
