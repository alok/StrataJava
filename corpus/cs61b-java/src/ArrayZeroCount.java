public class ArrayZeroCount {
    public static boolean isZero(int value) {
        return value == 0;
    }

    public static int countZero(int[] items) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isZero(items[i])) {
                count += 1;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        int[] data = new int[] {0, 5, 0, 7};
        System.out.println(countZero(data));
    }
}
