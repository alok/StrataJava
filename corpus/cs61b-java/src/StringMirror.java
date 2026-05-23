public class StringMirror {
    public static String reverse(String text) {
        StringBuilder builder = new StringBuilder();
        for (int i = text.length() - 1; i >= 0; i -= 1) {
            builder.append(text.charAt(i));
        }
        return builder.toString();
    }

    public static String mirror(String text) {
        return text + reverse(text);
    }

    public static void main(String[] args) {
        System.out.println(reverse("abc"));
        System.out.println(mirror("ab"));
    }
}
