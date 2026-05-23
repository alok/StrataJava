/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-fa25 hw02/src/StarTriangleN.java.
 * Focus: nested bounded loops for text construction.
 */
public class StarTriangleBounded {
    /**
     * CS61B-style intent: Build one line containing width stars.
     * Semantic target: For width >= 0, result length is width and every character is '*'.
     */
    public static String lineOfStars(int width) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < width; i += 1) {
            builder.append('*');
        }
        return builder.toString();
    }

    /**
     * CS61B-style intent: Build a newline-separated triangle with row widths 1 through height.
     * Semantic target: For height >= 0, result has height rows and row r has r stars.
     */
    public static String triangle(int height) {
        StringBuilder builder = new StringBuilder();
        for (int row = 1; row <= height; row += 1) {
            builder.append(lineOfStars(row));
            if (row < height) {
                builder.append('\n');
            }
        }
        return builder.toString();
    }

    /**
     * CS61B-style intent: Count the number of star cells in a triangle.
     * Semantic target: For height >= 0, result = height * (height + 1) / 2.
     */
    public static int triangleAreaCells(int height) {
        int cells = 0;
        for (int row = 1; row <= height; row += 1) {
            cells += row;
        }
        return cells;
    }

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(triangle(5));
        System.out.println(triangleAreaCells(5));
    }
}

