/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw02/src/DoubleUp.java.
 * Focus: mirroring a string around itself.
 */
public class StringMirror {
    /**
     * CS61B-style intent: Return characters in reverse order.
     * Semantic target: For length n, result[i] = text[n - i - 1].
     */
    public static String reverse(String text) {
        StringBuilder builder = new StringBuilder();
        for (int i = text.length() - 1; i >= 0; i -= 1) {
            builder.append(text.charAt(i));
        }
        return builder.toString();
    }

    /**
     * CS61B-style intent: Append the reverse of text to text.
     * Semantic target: Result is text concatenated with reverse(text).
     */
    public static String mirror(String text) {
        return text + reverse(text);
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(reverse("abc"));
        System.out.println(mirror("ab"));
    }
}
