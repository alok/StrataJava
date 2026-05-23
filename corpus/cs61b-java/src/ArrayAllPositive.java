public class ArrayAllPositive {
    public static boolean allPositive(int[] items) {
        boolean ok = true;
        for (int i = 0; i < items.length; i += 1) {
            if (items[i] <= 0) {
                ok = false;
            }
        }
        return ok;
    }

    public static int positiveBonus(int[] items) {
        if (allPositive(items)) {
            return items.length;
        }
        return 0;
    }

    public static void main(String[] args) {
        int[] data = new int[] {1, 2, 3};
        System.out.println(allPositive(data));
        System.out.println(positiveBonus(data));
    }
}
