public class EvenFilterArray {
    public static boolean isEven(int value) {
        return value % 2 == 0;
    }

    public static int countEvens(int[] items) {
        int count = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isEven(items[i])) {
                count += 1;
            }
        }
        return count;
    }

    public static int[] evens(int[] items) {
        int[] result = new int[countEvens(items)];
        int outputIndex = 0;
        for (int i = 0; i < items.length; i += 1) {
            if (isEven(items[i])) {
                result[outputIndex] = items[i];
                outputIndex += 1;
            }
        }
        return result;
    }

    public static int sum(int[] items) {
        int total = 0;
        for (int i = 0; i < items.length; i += 1) {
            total += items[i];
        }
        return total;
    }

    public static void main(String[] args) {
        int[] data = new int[] {1, 2, 3, 4, 5, 6};
        System.out.println(countEvens(data));
        System.out.println(sum(evens(data)));
    }
}

