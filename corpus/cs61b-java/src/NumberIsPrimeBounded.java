public class NumberIsPrimeBounded {
    public static boolean isPrime(int n) {
        boolean prime = n >= 2;
        for (int d = 2; d < n; d += 1) {
            if (n % d == 0) {
                prime = false;
            }
        }
        return prime;
    }

    public static int primeBonus(int n) {
        if (isPrime(n)) {
            return n;
        }
        return 0;
    }

    public static void main(String[] args) {
        System.out.println(isPrime(13));
        System.out.println(primeBonus(12));
    }
}
