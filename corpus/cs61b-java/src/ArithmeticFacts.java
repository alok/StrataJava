public class ArithmeticFacts {
    public static int product(int a, int b) { // human-checked
        return a * b;
    }

    public static int sum(int a, int b) { // human-checked
        return a + b;
    }

    public static int boundedPower(int base, int exponent) { // human-checked
        int result = 1;
        for (int i = 0; i < exponent; i += 1) {
            result = product(result, base);
        }
        return result;
    }

    public static int maxOfThree(int a, int b, int c) { // human-checked
        int best = a;
        if (b > best) {
            best = b;
        }
        if (c > best) {
            best = c;
        }
        return best;
    }

    public static int score(int a, int b, int c) {
        int pairTotal = sum(a, b);
        int scaled = product(pairTotal, c);
        return sum(scaled, maxOfThree(a, b, c));
    }

    public static void main(String[] args) {
        System.out.println(score(2, 3, 4));
        System.out.println(boundedPower(3, 4));
    }
}

