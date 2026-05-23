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
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(isPalindrome("level"));
        System.out.println(isPalindrome("java"));
    }
}
