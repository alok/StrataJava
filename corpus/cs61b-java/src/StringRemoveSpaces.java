public class StringRemoveSpaces {
    public static String removeSpaces(String text) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < text.length(); i += 1) {
            if (text.charAt(i) != ' ') {
                builder.append(text.charAt(i));
            }
        }
        return builder.toString();
    }

    public static int compactLength(String text) {
        return removeSpaces(text).length();
    }

    public static void main(String[] args) {
        System.out.println(removeSpaces("a b c"));
        System.out.println(compactLength("a b c"));
    }
}
