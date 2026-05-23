public class NumberGcdByScan {
    public static int gcdByScan(int a, int b) {
        int limit = a;
        if (b < limit) {
            limit = b;
        }
        int best = 1;
        for (int d = 1; d <= limit; d += 1) {
            if (a % d == 0 && b % d == 0) {
                best = d;
            }
        }
        return best;
    }

    public static boolean relativelyPrime(int a, int b) {
        return gcdByScan(a, b) == 1;
    }

    public static void main(String[] args) {
        System.out.println(gcdByScan(12, 18));
        System.out.println(relativelyPrime(8, 15));
    }
}
