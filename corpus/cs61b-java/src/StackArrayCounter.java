/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw05/tests/TestStack.java.
 * Focus: small bounded array-backed stack counter.
 */
public class StackArrayCounter {
    private int[] values;
    private int size;

    /**
     * CS61B-style intent: Create a bounded array-backed stack counter.
     * Semantic target: size starts at zero and capacity is fixed by the backing array.
     */
    public StackArrayCounter(int capacity) {
        values = new int[capacity];
        size = 0;
    }

    /**
     * CS61B-style intent: Push a value if capacity remains.
     * Semantic target: Result is true iff size grows by one and the value is stored.
     */
    public boolean push(int value) {
        if (size < values.length) {
            values[size] = value;
            size += 1;
            return true;
        }
        return false;
    }

    /**
     * CS61B-style intent: Sum stack contents up to size.
     * Semantic target: Result is the sum of values[0..size-1].
     */
    public int sum() {
        int total = 0;
        for (int i = 0; i < size; i += 1) {
            total += values[i];
        }
        return total;
    }

    /**
     * CS61B-style intent: Return the current stack size.
     * Semantic target: Result equals the private size field.
     */
    public int size() {
        return size;
    }

    /**
     * CS61B-style intent: Run a fixed stack sequence.
     * Semantic target: Result is 14 for pushes 5 and 7 plus size 2.
     */
    public static int demo() {
        StackArrayCounter stack = new StackArrayCounter(3);
        stack.push(5);
        stack.push(7);
        return stack.sum() + stack.size();
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(demo());
    }
}
