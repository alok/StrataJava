public class IndexedString {
    public static String indexed(String text) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < text.length(); i += 1) {
            int reverseIndex = text.length() - i - 1;
            builder.append(text.charAt(i));
            builder.append(reverseIndex);
        }
        return builder.toString();
    }

    public static int digitWeight(String text) {
        int total = 0;
        for (int i = 0; i < text.length(); i += 1) {
            total += text.length() - i - 1;
        }
        return total;
    }

    public static void main(String[] args) {
        System.out.println(indexed("hello"));
        System.out.println(digitWeight("hello"));
    }
}

