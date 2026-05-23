public class MatrixRowSums {
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

    public static int firstRowSum(int[][] matrix) {
        return rowSums(matrix)[0];
    }

    public static void main(String[] args) {
        int[][] matrix = new int[][] {{1, 2}, {3, 4}};
        System.out.println(rowSums(matrix)[1]);
        System.out.println(firstRowSum(matrix));
    }
}
