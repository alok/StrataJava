public class DoubleCharacters {
    public static String doubleUp(String text) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < text.length(); i += 1) {
            char c = text.charAt(i);
            builder.append(c);
            builder.append(c);
        }
        return builder.toString();
    }

    public static int doubledLength(String text) {
        return doubleUp(text).length();
    }

    public static void main(String[] args) {
        System.out.println(doubleUp("hello"));
        System.out.println(doubledLength("strata"));
    }
}

