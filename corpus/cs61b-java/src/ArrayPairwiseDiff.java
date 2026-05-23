public class ArrayPairwiseDiff {
    public static int[] differences(int[] items) {
        int[] result = new int[items.length - 1];
        for (int i = 0; i < result.length; i += 1) {
            result[i] = items[i + 1] - items[i];
        }
        return result;
    }

    public static int firstDifference(int[] items) {
        return differences(items)[0];
    }

    public static void main(String[] args) {
        int[] data = new int[] {3, 8, 10};
        System.out.println(differences(data)[1]);
        System.out.println(firstDifference(data));
    }
}
