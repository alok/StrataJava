public class ArrayIsSorted {
    public static boolean isSorted(int[] items) {
        boolean sorted = true;
        for (int i = 1; i < items.length; i += 1) {
            if (items[i] < items[i - 1]) {
                sorted = false;
            }
        }
        return sorted;
    }

    public static int sortedScore(int[] items) {
        if (isSorted(items)) {
            return items.length;
        }
        return -items.length;
    }

    public static void main(String[] args) {
        int[] data = new int[] {1, 3, 3, 8};
        System.out.println(isSorted(data));
        System.out.println(sortedScore(data));
    }
}
