public class StackArrayCounter {
    private int[] values;
    private int size;

    public StackArrayCounter(int capacity) {
        values = new int[capacity];
        size = 0;
    }

    public boolean push(int value) {
        if (size < values.length) {
            values[size] = value;
            size += 1;
            return true;
        }
        return false;
    }

    public int sum() {
        int total = 0;
        for (int i = 0; i < size; i += 1) {
            total += values[i];
        }
        return total;
    }

    public int size() {
        return size;
    }

    public static int demo() {
        StackArrayCounter stack = new StackArrayCounter(3);
        stack.push(5);
        stack.push(7);
        return stack.sum() + stack.size();
    }

    public static void main(String[] args) {
        System.out.println(demo());
    }
}
