public class ArrayCopy {
    public static int[] copy(int[] items) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            result[i] = items[i];
        }
        return result;
    }

    public static int copyAndSum(int[] items) {
        int[] copied = copy(items);
        int total = 0;
        for (int i = 0; i < copied.length; i += 1) {
            total += copied[i];
        }
        return total;
    }

    public static void main(String[] args) {
        int[] data = new int[] {3, 1, 4};
        System.out.println(copy(data)[1]);
        System.out.println(copyAndSum(data));
    }
}
