/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw02/src/DoubleUp.java.
 * Focus: removing spaces from a string.
 */
public class StringRemoveSpaces {
    /**
     * CS61B-style intent: Drop space characters.
     * Semantic target: Result is the subsequence of non-space input characters.
     */
    public static String removeSpaces(String text) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < text.length(); i += 1) {
            if (text.charAt(i) != ' ') {
                builder.append(text.charAt(i));
            }
        }
        return builder.toString();
    }

    /**
     * CS61B-style intent: Return the length after removing spaces.
     * Semantic target: Result is the count of non-space input characters.
     */
    public static int compactLength(String text) {
        return removeSpaces(text).length();
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(removeSpaces("a b c"));
        System.out.println(compactLength("a b c"));
    }
}
