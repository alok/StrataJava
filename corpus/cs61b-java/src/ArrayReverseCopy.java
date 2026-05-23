public class ArrayReverseCopy {
    public static int[] reverseCopy(int[] items) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            result[i] = items[items.length - i - 1];
        }
        return result;
    }

    public static int firstAfterReverse(int[] items) {
        return reverseCopy(items)[0];
    }

    public static void main(String[] args) {
        int[] data = new int[] {2, 4, 6};
        System.out.println(reverseCopy(data)[0]);
        System.out.println(firstAfterReverse(data));
    }
}
