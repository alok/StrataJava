public class ArrayLastIndex {
    public static int lastIndexOf(int[] items, int target) {
        int found = -1;
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] == target) {
                found = i;
            }
        }
        return found;
    }

    public static int distanceBetweenFirstAndLast(int[] items, int target) {
        int first = ArrayFirstIndex.firstIndexOf(items, target);
        int last = lastIndexOf(items, target);
        return last - first;
    }

    public static void main(String[] args) {
        int[] data = new int[] {4, 1, 4};
        System.out.println(lastIndexOf(data, 4));
        System.out.println(distanceBetweenFirstAndLast(data, 4));
    }
}
