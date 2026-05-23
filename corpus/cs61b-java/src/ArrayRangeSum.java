public class ArrayRangeSum {
    public static int sumRange(int[] items, int start, int end) {
        int total = 0;
        for (int i = start; i < end; i += 1) {
            total += items[i];
        }
        return total;
    }

    public static int sumAll(int[] items) {
        return sumRange(items, 0, items.length);
    }

    public static void main(String[] args) {
        int[] data = new int[] {2, 4, 6, 8};
        System.out.println(sumRange(data, 1, 3));
        System.out.println(sumAll(data));
    }
}
