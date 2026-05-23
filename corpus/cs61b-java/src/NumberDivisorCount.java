public class NumberDivisorCount {
    public static int divisorCount(int n) {
        int count = 0;
        for (int d = 1; d <= n; d += 1) {
            if (n % d == 0) {
                count += 1;
            }
        }
        return count;
    }

    public static boolean hasTwoDivisors(int n) {
        return divisorCount(n) == 2;
    }

    public static void main(String[] args) {
        System.out.println(divisorCount(12));
        System.out.println(hasTwoDivisors(13));
    }
}
