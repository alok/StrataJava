public class NumberFactorialBounded {
    public static int factorial(int n) {
        int result = 1;
        for (int i = 2; i <= n; i += 1) {
            result *= i;
        }
        return result;
    }

    public static int factorialPlusOne(int n) {
        return factorial(n) + 1;
    }

    public static void main(String[] args) {
        System.out.println(factorial(5));
        System.out.println(factorialPlusOne(4));
    }
}
