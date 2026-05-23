public class ArrayFirstIndex {
    public static int firstIndexOf(int[] items, int target) {
        int found = -1;
        for (int i = 0; i < items.length; i += 1) {
            if (found == -1 && items[i] == target) {
                found = i;
            }
        }
        return found;
    }

    public static boolean contains(int[] items, int target) {
        return firstIndexOf(items, target) >= 0;
    }

    public static void main(String[] args) {
        int[] data = new int[] {4, 1, 4};
        System.out.println(firstIndexOf(data, 4));
        System.out.println(contains(data, 9));
    }
}
