/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw02/src/PrintIndexed.java.
 * Focus: string indexing and reverse position arithmetic.
 */
public class IndexedString {
    /**
     * CS61B-style intent: Append each character followed by its reverse index.
     * Semantic target: For input length n, output is the concatenation of text[i] and decimal(n - i - 1) for i in 0..n-1.
     */
    public static String indexed(String text) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < text.length(); i += 1) {
            int reverseIndex = text.length() - i - 1;
            builder.append(text.charAt(i));
            builder.append(reverseIndex);
        }
        return builder.toString();
    }

    /**
     * CS61B-style intent: Sum the reverse indices for the input string.
     * Semantic target: For length n >= 0, result = n * (n - 1) / 2.
     */
    public static int digitWeight(String text) {
        int total = 0;
        for (int i = 0; i < text.length(); i += 1) {
            total += text.length() - i - 1;
        }
        return total;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(indexed("hello"));
        System.out.println(digitWeight("hello"));
    }
}

