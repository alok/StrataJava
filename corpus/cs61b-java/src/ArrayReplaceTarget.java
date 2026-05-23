public class ArrayReplaceTarget {
    public static int[] replace(int[] items, int target, int replacement) {
        int[] result = new int[items.length];
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] == target) {
                result[i] = replacement;
            } else {
                result[i] = items[i];
            }
        }
        return result;
    }

    public static int replacedCount(int[] items, int target, int replacement) {
        int[] result = replace(items, target, replacement);
        return ArrayCountTarget.countTarget(result, replacement);
    }

    public static void main(String[] args) {
        int[] data = new int[] {1, 2, 1};
        System.out.println(replace(data, 1, 9)[2]);
        System.out.println(replacedCount(data, 1, 9));
    }
}
