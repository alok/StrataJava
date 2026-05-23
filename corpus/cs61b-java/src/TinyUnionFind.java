/**
 * CS61B-style exercise inspired by Berkeley-CS61B/skeleton-sp24 lab05/src/UnionFind.java.
 * Focus: array-backed disjoint-set operations without failure signaling.
 */
public class TinyUnionFind {
    private int[] parent;

    /**
     * CS61B-style intent: Create a union-find with the requested number of items.
     * Semantic target: every item starts in its own singleton set.
     */
    public TinyUnionFind(int size) {
        parent = new int[size];
        for (int i = 0; i < parent.length; i += 1) {
            parent[i] = -1;
        }
    }

    /**
     * CS61B-style intent: Check whether an item index is inside the parent array.
     * Semantic target: result is true iff 0 <= item < parent.length.
     */
    public boolean valid(int item) {
        return item >= 0 && item < parent.length;
    }

    /**
     * CS61B-style intent: Find the representative root, returning -1 for invalid input.
     * Semantic target: If item is invalid, result = -1; otherwise result is a root reachable from item in the parent forest.
     */
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

    /**
     * CS61B-style intent: Return the set size for a valid item, else zero.
     * Semantic target: If root(item) < 0, result = 0; otherwise result = -parent[root(item)].
     */
    public int sizeOf(int item) {
        int r = root(item);
        if (r < 0) {
            return 0;
        }
        return -parent[r];
    }

    /**
     * CS61B-style intent: Check whether two items have the same valid root.
     * Semantic target: result is true iff root(left) >= 0 and root(left) = root(right).
     */
    public boolean connected(int left, int right) {
        int leftRoot = root(left);
        int rightRoot = root(right);
        return leftRoot >= 0 && leftRoot == rightRoot;
    }

    /**
     * CS61B-style intent: Join two sets by size; do nothing for invalid or already-connected items.
     * Semantic target: After a successful union, left and right are connected and all previous connections are preserved.
     */
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

    /**
     * CS61B-style intent: Construct a six-item union-find, union three edges, then return the component size if connected.
     * Semantic target: result = 4 for the fixed demo sequence.
     */
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

    /**
     * CS61B-style intent: Run a small smoke example for this class.
     * Semantic target: exercise representative calls without changing corpus semantics.
     */
    public static void main(String[] args) {
        System.out.println(demoScore());
    }
}
