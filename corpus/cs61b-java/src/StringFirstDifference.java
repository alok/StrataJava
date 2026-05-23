public class StringFirstDifference {
    public static int firstDifference(String left, String right) {
        int found = -1;
        for (int i = 0; i < left.length(); i += 1) {
            if (found == -1 && left.charAt(i) != right.charAt(i)) {
                found = i;
            }
        }
        return found;
    }

    public static boolean samePrefix(String left, String right) {
        return firstDifference(left, right) == -1;
    }

    public static void main(String[] args) {
        System.out.println(firstDifference("abcd", "abed"));
        System.out.println(samePrefix("abc", "abc"));
    }
}
