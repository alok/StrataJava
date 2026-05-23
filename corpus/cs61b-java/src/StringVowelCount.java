public class StringVowelCount {
    public static boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    public static int countVowels(String text) {
        int count = 0;
        for (int i = 0; i < text.length(); i += 1) {
            if (isVowel(text.charAt(i))) {
                count += 1;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        System.out.println(isVowel('e'));
        System.out.println(countVowels("strata"));
    }
}
