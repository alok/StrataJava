public class StringRunCount {
    public static int runCount(String text) {
        int runs = 0;
        for (int i = 0; i < text.length(); i += 1) {
            if (i == 0 || text.charAt(i) != text.charAt(i - 1)) {
                runs += 1;
            }
        }
        return runs;
    }

    public static boolean hasOneRun(String text) {
        return runCount(text) == 1;
    }

    public static void main(String[] args) {
        System.out.println(runCount("aaabbc"));
        System.out.println(hasOneRun("aaa"));
    }
}
