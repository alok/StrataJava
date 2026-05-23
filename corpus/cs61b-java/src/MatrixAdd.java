public class MatrixAdd {
    public static int[][] add(int[][] left, int[][] right) {
        int[][] result = new int[left.length][left[0].length];
        for (int row = 0; row < left.length; row += 1) {
            for (int col = 0; col < left[row].length; col += 1) {
                result[row][col] = left[row][col] + right[row][col];
            }
        }
        return result;
    }

    public static int topLeftSum(int[][] left, int[][] right) {
        return add(left, right)[0][0];
    }

    public static void main(String[] args) {
        int[][] left = new int[][] {{1, 2}, {3, 4}};
        int[][] right = new int[][] {{5, 6}, {7, 8}};
        System.out.println(add(left, right)[1][1]);
        System.out.println(topLeftSum(left, right));
    }
}
