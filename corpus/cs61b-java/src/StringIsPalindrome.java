public class StringIsPalindrome {
    public static boolean isPalindrome(String text) {
        boolean ok = true;
        for (int i = 0; i < text.length(); i += 1) {
            if (text.charAt(i) != text.charAt(text.length() - i - 1)) {
                ok = false;
            }
        }
        return ok;
    }

    public static int palindromeScore(String text) {
        if (isPalindrome(text)) {
            return text.length();
        }
        return 0;
    }

    public static void main(String[] args) {
        System.out.println(isPalindrome("level"));
        System.out.println(palindromeScore("java"));
    }
}
