/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw02/src/PrintIndexed.java.
 * Focus: counting vowels in a string.
 */
public class StringVowelCount {
    /**
     * CS61B-style intent: Classify lowercase vowels.
     * Semantic target: Result is true iff c is one of a,e,i,o,u.
     */
    public static boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    /**
     * CS61B-style intent: Count vowels in text.
     * Semantic target: Result is the number of character positions classified as vowels.
     */
    public static int countVowels(String text) {
        int count = 0;
        for (int i = 0; i < text.length(); i += 1) {
            if (isVowel(text.charAt(i))) {
                count += 1;
            }
        }
        return count;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(isVowel('e'));
        System.out.println(countVowels("strata"));
    }
}
