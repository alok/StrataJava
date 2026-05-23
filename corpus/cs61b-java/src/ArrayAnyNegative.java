public class ArrayAnyNegative {
    public static boolean anyNegative(int[] items) {
        boolean found = false;
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] < 0) {
                found = true;
            }
        }
        return found;
    }

    public static int negativePenalty(int[] items) {
        if (anyNegative(items)) {
            return -1;
        }
        return 0;
    }

    public static void main(String[] args) {
        int[] data = new int[] {1, -2, 3};
        System.out.println(anyNegative(data));
        System.out.println(negativePenalty(data));
    }
}
