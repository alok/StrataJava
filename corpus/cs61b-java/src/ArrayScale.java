public class ArrayScale {
    public static int[] scale(int[] items, int factor) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            result[i] = items[i] * factor;
        }
        return result;
    }

    public static int scaledSum(int[] items, int factor) {
        int[] scaled = scale(items, factor);
        int total = 0;
        for (int i = 0; i < scaled.length; i += 1) {
            total += scaled[i];
        }
        return total;
    }

    public static void main(String[] args) {
        int[] data = new int[] {2, 3, 4};
        System.out.println(scale(data, 3)[1]);
        System.out.println(scaledSum(data, 2));
    }
}
