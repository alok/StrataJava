/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp21/lab1/HelloNumbers.java.
 * Focus: digit sum with bounded decimal places.
 */
public class NumberDigitSum {
    /**
     * CS61B-style intent: Sum up to six decimal digits.
     * Semantic target: Result is the sum of six low-order base-10 digits.
     */
    public static int digitSumUpToSix(int value) {
        int n = value;
        int total = 0;
        for (int i = 0; i < 6; i += 1) {
            total += n % 10;
            n = n / 10;
        }
        return total;
    }

    /**
     * CS61B-style intent: Check parity of the bounded digit sum.
     * Semantic target: Result is true iff digitSumUpToSix(value) is even.
     */
    public static boolean digitSumEven(int value) {
        return digitSumUpToSix(value) % 2 == 0;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(digitSumUpToSix(12345));
        System.out.println(digitSumEven(222));
    }
}
