public class StringRepeatEach {
    public static String repeatEach(String text, int times) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < text.length(); i += 1) {
            for (int j = 0; j < times; j += 1) {
                builder.append(text.charAt(i));
            }
        }
        return builder.toString();
    }

    public static int repeatedLength(String text, int times) {
        return repeatEach(text, times).length();
    }

    public static void main(String[] args) {
        System.out.println(repeatEach("ab", 3));
        System.out.println(repeatedLength("abc", 2));
    }
}
