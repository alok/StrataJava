/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw02/src/DoubleUp.java.
 * Focus: repeating every character a fixed number of times.
 */
public class StringRepeatEach {
    /**
     * CS61B-style intent: Repeat each character times times.
     * Semantic target: For times >= 0, result length is text.length() * times.
     */
    public static String repeatEach(String text, int times) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < text.length(); i += 1) {
            for (int j = 0; j < times; j += 1) {
                builder.append(text.charAt(i));
            }
        }
        return builder.toString();
    }

    /**
     * CS61B-style intent: Return repeatEach output length.
     * Semantic target: Result is text.length() * times for times >= 0.
     */
    public static int repeatedLength(String text, int times) {
        return repeatEach(text, times).length();
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(repeatEach("ab", 3));
        System.out.println(repeatedLength("abc", 2));
    }
}
