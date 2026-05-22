public class ArrayMinMax {
    public static int minValue(int[] items) {
        int best = items[0];
        for (int i = 1; i < items.length; i += 1) {
            if (items[i] < best) {
                best = items[i];
            }
        }
        return best;
    }

    public static int maxValue(int[] items) {
        int best = items[0];
        for (int i = 1; i < items.length; i += 1) {
            if (items[i] > best) {
                best = items[i];
            }
        }
        return best;
    }

    public static int minMaxDifference(int[] items) {
        return maxValue(items) - minValue(items);
    }

    public static int secondLargestOfFour(int[] items) {
        int largest = items[0];
        int second = items[1];
        if (second > largest) {
            int oldLargest = largest;
            largest = second;
            second = oldLargest;
        }
        for (int i = 2; i < 4; i += 1) {
            if (items[i] > largest) {
                second = largest;
                largest = items[i];
            } else if (items[i] > second) {
                second = items[i];
            }
        }
        return second;
    }

    public static void main(String[] args) {
        int[] data = new int[] {7, 2, 9, 4};
        System.out.println(minMaxDifference(data));
        System.out.println(secondLargestOfFour(data));
    }
}

