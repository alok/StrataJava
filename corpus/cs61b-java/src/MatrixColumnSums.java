public class MatrixColumnSums {
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

    public static int firstColumnSum(int[][] matrix) {
        return columnSums(matrix)[0];
    }

    public static void main(String[] args) {
        int[][] matrix = new int[][] {{1, 2}, {3, 4}};
        System.out.println(columnSums(matrix)[1]);
        System.out.println(firstColumnSum(matrix));
    }
}
