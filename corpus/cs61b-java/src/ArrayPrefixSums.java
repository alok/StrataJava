public class ArrayPrefixSums {
    public static int[] prefixSums(int[] items) {
        int[] result = new int[items.length];
        int total = 0;
        for (int i = 0; i < items.length; i += 1) {
            total += items[i];
            result[i] = total;
        }
        return result;
    }

    public static int finalPrefix(int[] items) {
        int[] sums = prefixSums(items);
        return sums[sums.length - 1];
    }

    public static void main(String[] args) {
        int[] data = new int[] {1, 2, 3};
        System.out.println(prefixSums(data)[2]);
        System.out.println(finalPrefix(data));
    }
}
