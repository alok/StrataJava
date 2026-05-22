public class StarTriangleBounded {
    public static String lineOfStars(int width) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < width; i += 1) {
            builder.append('*');
        }
        return builder.toString();
    }

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

    public static int triangleAreaCells(int height) {
        int cells = 0;
        for (int row = 1; row <= height; row += 1) {
            cells += row;
        }
        return cells;
    }

    public static void main(String[] args) {
        System.out.println(triangle(5));
        System.out.println(triangleAreaCells(5));
    }
}

