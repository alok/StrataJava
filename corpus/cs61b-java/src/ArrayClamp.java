public class ArrayClamp {
    public static int clampValue(int value, int low, int high) {
        if (value < low) {
            return low;
        }
        if (value > high) {
            return high;
        }
        return value;
    }

    public static int[] clampAll(int[] items, int low, int high) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            result[i] = clampValue(items[i], low, high);
        }
        return result;
    }

    public static void main(String[] args) {
        int[] data = new int[] {-1, 5, 99};
        System.out.println(clampValue(12, 0, 10));
        System.out.println(clampAll(data, 0, 10)[2]);
    }
}
