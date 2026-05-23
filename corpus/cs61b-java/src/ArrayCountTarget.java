public class ArrayCountTarget {
    public static int countTarget(int[] items, int target) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] == target) {
                count += 1;
            }
        }
        return count;
    }

    public static boolean appearsExactlyOnce(int[] items, int target) {
        return countTarget(items, target) == 1;
    }

    public static void main(String[] args) {
        int[] data = new int[] {2, 2, 5};
        System.out.println(countTarget(data, 2));
        System.out.println(appearsExactlyOnce(data, 5));
    }
}
