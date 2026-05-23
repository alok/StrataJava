public class ArrayWeightedSum {
    public static int weightedSum(int[] items) {
        int total = 0;
        for (int i = 0; i < items.length; i += 1) {
            total += items[i] * (i + 1);
        }
        return total;
    }

    public static int weightedDifference(int[] left, int[] right) {
        return weightedSum(left) - weightedSum(right);
    }

    public static void main(String[] args) {
        int[] left = new int[] {1, 2, 3};
        int[] right = new int[] {1, 1, 1};
        System.out.println(weightedSum(left));
        System.out.println(weightedDifference(left, right));
    }
}
