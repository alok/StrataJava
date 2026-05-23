/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java.
 * Focus: counting word and character occurrences.
 */
public class OccurrenceCounts {
    /**
     * CS61B-style intent: Count exact word matches.
     * Semantic target: result is the number of indices i where words[i].equals(target).
     */
    public static int countWord(String[] words, String target) {
        int count = 0;
        for (int i = 0; i < words.length; i += 1) {
            if (words[i].equals(target)) {
                count += 1;
            }
        }
        return count;
    }

    /**
     * CS61B-style intent: Count target characters across all words.
     * Semantic target: result is the sum over words of occurrences of target in each word.
     */
    public static int countCharacter(String[] words, char target) {
        int count = 0;
        for (int i = 0; i < words.length; i += 1) {
            String word = words[i];
            for (int j = 0; j < word.length(); j += 1) {
                if (word.charAt(j) == target) {
                    count += 1;
                }
            }
        }
        return count;
    }

    /**
     * Smoke-only harness: prints representative calls for comparison.
     * Not a semantic target; public methods above carry the checked intent.
     */
    public static void main(String[] args) {
        String[] words = new String[] {"bee", "bear", "bee", "bead"};
        System.out.println(countWord(words, "bee"));
        System.out.println(countCharacter(words, 'e'));
    }
}
