public class OccurrenceCounts {
    public static int countWord(String[] words, String target) {
        int count = 0;
        for (int i = 0; i < words.length; i += 1) {
            if (words[i].equals(target)) {
                count += 1;
            }
        }
        return count;
    }

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

    public static int score(String[] words, String targetWord, char targetChar) {
        return countWord(words, targetWord) * 10 + countCharacter(words, targetChar);
    }

    public static void main(String[] args) {
        String[] words = new String[] {"bee", "bear", "bee", "bead"};
        System.out.println(countWord(words, "bee"));
        System.out.println(score(words, "bee", 'e'));
    }
}

