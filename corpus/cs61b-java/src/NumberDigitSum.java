public class NumberDigitSum {
    public static int digitSumUpToSix(int value) {
        int n = value;
        int total = 0;
        for (int i = 0; i < 6; i += 1) {
            total += n % 10;
            n = n / 10;
        }
        return total;
    }

    public static boolean digitSumEven(int value) {
        return digitSumUpToSix(value) % 2 == 0;
    }

    public static void main(String[] args) {
        System.out.println(digitSumUpToSix(12345));
        System.out.println(digitSumEven(222));
    }
}
