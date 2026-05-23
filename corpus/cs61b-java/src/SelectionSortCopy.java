public class SelectionSortCopy {
    public static int[] sortedCopy(int[] items) {
        int[] result = ArrayCopy.copy(items);
        for (int i = 0; i < result.length; i += 1) {
            int best = i;
            for (int j = i + 1; j < result.length; j += 1) {
                if (result[j] < result[best]) {
                    best = j;
                }
            }
            int temp = result[i];
            result[i] = result[best];
            result[best] = temp;
        }
        return result;
    }

    public static int smallest(int[] items) {
        return sortedCopy(items)[0];
    }

    public static void main(String[] args) {
        int[] data = new int[] {4, 1, 3};
        System.out.println(sortedCopy(data)[0]);
        System.out.println(smallest(data));
    }
}
