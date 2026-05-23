/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw02/src/PrintIndexed.java.
 * Focus: first differing character position.
 */
public class StringFirstDifference {
    /**
     * CS61B-style intent: Find the first differing index.
     * Semantic target: Result is the least index where characters differ, or -1 if none in the scanned length.
     */
    public static int firstDifference(String left, String right) {
        int found = -1;
        for (int i = 0; i < left.length(); i += 1) {
            if (found == -1 && left.charAt(i) != right.charAt(i)) {
                found = i;
            }
        }
        return found;
    }

    /**
     * CS61B-style intent: Check whether no difference was found.
     * Semantic target: Result is true iff firstDifference returns -1.
     */
    public static boolean samePrefix(String left, String right) {
        return firstDifference(left, right) == -1;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(firstDifference("abcd", "abed"));
        System.out.println(samePrefix("abc", "abc"));
    }
}
