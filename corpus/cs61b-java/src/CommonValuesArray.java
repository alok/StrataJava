public class CommonValuesArray {
    public static boolean containsBefore(int[] items, int limit, int target) {
        for (int i = 0; i < limit; i += 1) {
            if (items[i] == target) {
                return true;
            }
        }
        return false;
    }

    public static int countCommonDistinct(int[] left, int[] right) {
        int count = 0;
        int[] seen = new int[left.length];
        for (int i = 0; i < left.length; i += 1) {
            if (!containsBefore(seen, count, left[i]) && contains(right, left[i])) {
                seen[count] = left[i];
                count += 1;
            }
        }
        return count;
    }

    public static boolean contains(int[] items, int target) {
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] == target) {
                return true;
            }
        }
        return false;
    }

    public static int[] commonDistinct(int[] left, int[] right) {
        int count = countCommonDistinct(left, right);
        int[] result = new int[count];
        int used = 0;
        for (int i = 0; i < left.length; i += 1) {
            if (!containsBefore(result, used, left[i]) && contains(right, left[i])) {
                result[used] = left[i];
                used += 1;
            }
        }
        return result;
    }

    public static void main(String[] args) {
        int[] left = new int[] {4, 1, 4, 2, 8};
        int[] right = new int[] {2, 4, 9};
        int[] result = commonDistinct(left, right);
        for (int i = 0; i < result.length; i += 1) {
            System.out.println(result[i]);
        }
    }
}

