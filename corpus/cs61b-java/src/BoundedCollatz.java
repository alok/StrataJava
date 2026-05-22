public class BoundedCollatz {
    public static int nextNumber(int n) {
        if (n % 2 == 0) {
            return n / 2;
        }
        return 3 * n + 1;
    }

    public static int stepsUntilOne(int start, int maxSteps) {
        int value = start;
        int steps = 0;
        for (int i = 0; i < maxSteps; i += 1) {
            if (value == 1) {
                return steps;
            }
            value = nextNumber(value);
            steps += 1;
        }
        return steps;
    }

    public static int valueAfterSteps(int start, int maxSteps) {
        int value = start;
        for (int i = 0; i < maxSteps; i += 1) {
            if (value == 1) {
                return value;
            }
            value = nextNumber(value);
        }
        return value;
    }

    public static void main(String[] args) {
        System.out.println(stepsUntilOne(7, 20));
        System.out.println(valueAfterSteps(7, 5));
    }
}

