/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw02/src/DoubleUp.java.
 * Focus: string traversal with repeated output.
 */
public class DoubleCharacters {
    /**
     * CS61B-style intent: Repeat every character twice.
     * Semantic target: For input length n, output length is 2*n and positions 2*i and 2*i+1 both equal text[i].
     */
    public static String doubleUp(String text) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < text.length(); i += 1) {
            char c = text.charAt(i);
            builder.append(c);
            builder.append(c);
        }
        return builder.toString();
    }

    /**
     * CS61B-style intent: Return the length of doubleUp(text).
     * Semantic target: For input length n >= 0, result = 2*n.
     */
    public static int doubledLength(String text) {
        return doubleUp(text).length();
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(doubleUp("hello"));
        System.out.println(doubledLength("strata"));
    }
}

