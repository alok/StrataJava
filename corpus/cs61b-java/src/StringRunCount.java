/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw02/src/PrintIndexed.java.
 * Focus: counting runs of equal adjacent characters.
 */
public class StringRunCount {
    /**
     * CS61B-style intent: Count maximal equal-character runs.
     * Semantic target: Result is one plus the number of adjacent changes for nonempty text.
     */
    public static int runCount(String text) {
        int runs = 0;
        for (int i = 0; i < text.length(); i += 1) {
            if (i == 0 || text.charAt(i) != text.charAt(i - 1)) {
                runs += 1;
            }
        }
        return runs;
    }

    /**
     * CS61B-style intent: Check whether text has exactly one run.
     * Semantic target: Result is true iff runCount(text) is one.
     */
    public static boolean hasOneRun(String text) {
        return runCount(text) == 1;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        System.out.println(runCount("aaabbc"));
        System.out.println(hasOneRun("aaa"));
    }
}
