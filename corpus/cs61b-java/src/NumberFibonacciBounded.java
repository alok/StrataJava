public class NumberFibonacciBounded {
    public static int fibonacci(int n) {
        int previous = 0;
        int current = 1;
        for (int i = 0; i < n; i += 1) {
            int next = previous + current;
            previous = current;
            current = next;
        }
        return previous;
    }

    public static boolean fibonacciIsEven(int n) {
        return fibonacci(n) % 2 == 0;
    }

    public static void main(String[] args) {
        System.out.println(fibonacci(7));
        System.out.println(fibonacciIsEven(6));
    }
}
