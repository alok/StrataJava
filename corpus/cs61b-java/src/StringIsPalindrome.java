/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw06/src/adventure/PalindromeStage.java.
 * Focus: palindrome checking by mirrored indices.
 */
public class StringIsPalindrome {
    /**
     * CS61B-style intent: Check mirrored character equality.
     * Semantic target: Result is true iff every position equals its mirror.
     */
    public static boolean isPalindrome(String text) {
        boolean ok = true;
        for (int i = 0; i < text.length(); i += 1) {
            if (text.charAt(i) != text.charAt(text.length() - i - 1)) {
                ok = false;
            }
        }
        return ok;
    }

    /**
     * CS61B-style intent: Score palindromes by length.
     * Semantic target: Result is length iff isPalindrome is true, otherwise zero.
     */
    public static int palindromeScore(String text) {
        if (isPalindrome(text)) {
            return text.length();
        }
        return 0;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(isPalindrome("level"));
        System.out.println(palindromeScore("java"));
    }
}
