public class ArrayPositiveCount {
    public static boolean isPositive(int value) {
        return value > 0;
    }

    public static int countPositive(int[] items) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isPositive(items[i])) {
                count += 1;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        int[] data = new int[] {-2, 5, 0, 7};
        System.out.println(countPositive(data));
    }
}
