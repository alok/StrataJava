public class TinyUnionFind {
    private int[] parent;

    public TinyUnionFind(int size) {
        parent = new int[size];
        for (int i = 0; i < parent.length; i += 1) {
            parent[i] = -1;
        }
    }

    public boolean valid(int item) {
        return item >= 0 && item < parent.length;
    }

    public int root(int item) {
        if (!valid(item)) {
            return -1;
        }
        int current = item;
        for (int steps = 0; steps < parent.length; steps += 1) {
            if (parent[current] < 0) {
                return current;
            }
            current = parent[current];
        }
        return current;
    }

    public int sizeOf(int item) {
        int r = root(item);
        if (r < 0) {
            return 0;
        }
        return -parent[r];
    }

    public boolean connected(int left, int right) {
        int leftRoot = root(left);
        int rightRoot = root(right);
        return leftRoot >= 0 && leftRoot == rightRoot;
    }

    public void union(int left, int right) {
        int leftRoot = root(left);
        int rightRoot = root(right);
        if (leftRoot < 0 || rightRoot < 0 || leftRoot == rightRoot) {
            return;
        }
        int leftSize = -parent[leftRoot];
        int rightSize = -parent[rightRoot];
        if (leftSize < rightSize) {
            parent[rightRoot] = -(leftSize + rightSize);
            parent[leftRoot] = rightRoot;
        } else {
            parent[leftRoot] = -(leftSize + rightSize);
            parent[rightRoot] = leftRoot;
        }
    }

    public static int demoScore() {
        TinyUnionFind uf = new TinyUnionFind(6);
        uf.union(0, 1);
        uf.union(2, 3);
        uf.union(1, 2);
        if (uf.connected(0, 3)) {
            return uf.sizeOf(0);
        }
        return 0;
    }

    public static void main(String[] args) {
        System.out.println(demoScore());
    }
}
