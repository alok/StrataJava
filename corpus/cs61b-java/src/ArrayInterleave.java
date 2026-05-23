public class ArrayInterleave {
    public static int[] interleave(int[] left, int[] right) {
        int[] result = new int[left.length * 2];
        for (int i = 0; i < left.length; i += 1) {
            result[2 * i] = left[i];
            result[2 * i + 1] = right[i];
        }
        return result;
    }

    public static int interleavedLength(int[] left, int[] right) {
        return interleave(left, right).length;
    }

    public static void main(String[] args) {
        int[] left = new int[] {1, 3};
        int[] right = new int[] {2, 4};
        System.out.println(interleave(left, right)[3]);
        System.out.println(interleavedLength(left, right));
    }
}
