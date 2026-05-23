public class ArrayRotateLeft {
    public static int[] rotateLeftOne(int[] items) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            if (i + 1 < items.length) {
                result[i] = items[i + 1];
            } else {
                result[i] = items[0];
            }
        }
        return result;
    }

    public static int rotatedFirst(int[] items) {
        return rotateLeftOne(items)[0];
    }

    public static void main(String[] args) {
        int[] data = new int[] {9, 8, 7};
        System.out.println(rotateLeftOne(data)[2]);
        System.out.println(rotatedFirst(data));
    }
}
