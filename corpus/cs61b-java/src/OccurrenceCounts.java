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
     * CS61B-style intent: Combine word and character counts into a weighted score.
     * Semantic target: result = 10 * countWord(words, targetWord) + countCharacter(words, targetChar).
     */
    public static int score(String[] words, String targetWord, char targetChar) {
        return countWord(words, targetWord) * 10 + countCharacter(words, targetChar);
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        String[] words = new String[] {"bee", "bear", "bee", "bead"};
        System.out.println(countWord(words, "bee"));
        System.out.println(score(words, "bee", 'e'));
    }
}

