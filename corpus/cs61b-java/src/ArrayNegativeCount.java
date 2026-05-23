public class ArrayNegativeCount {
    public static boolean isNegative(int value) {
        return value < 0;
    }

    public static int countNegative(int[] items) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isNegative(items[i])) {
                count += 1;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        int[] data = new int[] {-2, 5, -3, 7};
        System.out.println(countNegative(data));
    }
}
