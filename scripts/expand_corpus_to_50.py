from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path
from textwrap import dedent
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
SRC_DIR = ROOT / "corpus" / "cs61b-java" / "src"
METADATA = ROOT / "metadata" / "corpus.json"
SEMANTICS = ROOT / "semantics" / "cs61b-java" / "stack-semantics.json"
CORE_SKETCH = ROOT / "semantics" / "strata-core" / "cs61b-java" / "CoreSketch.core.st"


@dataclass(frozen=True)
class MethodSpec:
    name: str
    signature: str
    surface: str
    functional: str
    operational: str
    verification: str


@dataclass(frozen=True)
class ProgramSpec:
    class_name: str
    topic: str
    source_probe: str
    features: list[str]
    source: str
    methods: list[MethodSpec]


def m(
    name: str,
    signature: str,
    surface: str,
    functional: str,
    operational: str,
    verification: str,
) -> MethodSpec:
    return MethodSpec(name, signature, surface, functional, operational, verification)


PROGRAMS: list[ProgramSpec] = [
    ProgramSpec(
        "ArrayRangeSum",
        "bounded range sum over an integer array",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "function calls", "int arithmetic"],
        """
        public class ArrayRangeSum {
            public static int sumRange(int[] items, int start, int end) {
                int total = 0;
                for (int i = start; i < end; i += 1) {
                    total += items[i];
                }
                return total;
            }

            public static int sumAll(int[] items) {
                return sumRange(items, 0, items.length);
            }

            public static void main(String[] args) {
                int[] data = new int[] {2, 4, 6, 8};
                System.out.println(sumRange(data, 1, 3));
                System.out.println(sumAll(data));
            }
        }
        """,
        [
            m("sumRange", "int sumRange(int[] items, int start, int end)", "Sum a half-open array range.", "Result is the finite sum of items[start..end-1].", "A bounded for loop accumulates one item per index.", "Loop invariant: total is the sum of the scanned prefix."),
            m("sumAll", "int sumAll(int[] items)", "Sum a whole array by delegating to sumRange.", "Result is the finite sum of all array elements.", "Calls sumRange with the full index range.", "Postcondition reuses the sumRange summary."),
        ],
    ),
    ProgramSpec(
        "ArrayWeightedSum",
        "weighted index sum over an integer array",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "int arithmetic"],
        """
        public class ArrayWeightedSum {
            public static int weightedSum(int[] items) {
                int total = 0;
                for (int i = 0; i < items.length; i += 1) {
                    total += items[i] * (i + 1);
                }
                return total;
            }

            public static int weightedDifference(int[] left, int[] right) {
                return weightedSum(left) - weightedSum(right);
            }

            public static void main(String[] args) {
                int[] left = new int[] {1, 2, 3};
                int[] right = new int[] {1, 1, 1};
                System.out.println(weightedSum(left));
                System.out.println(weightedDifference(left, right));
            }
        }
        """,
        [
            m("weightedSum", "int weightedSum(int[] items)", "Multiply each value by its one-based index and sum.", "Result is sum(items[i] * (i + 1)).", "A bounded loop accumulates weighted terms.", "Loop invariant: total is the weighted sum of the scanned prefix."),
            m("weightedDifference", "int weightedDifference(int[] left, int[] right)", "Compare two weighted sums.", "Result is weightedSum(left) - weightedSum(right).", "Calls weightedSum twice and subtracts.", "Postcondition reuses weightedSum summaries."),
        ],
    ),
    ProgramSpec(
        "ArrayPositiveCount",
        "counting positive values in an array",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java",
        ["arrays", "for", "if"],
        """
        public class ArrayPositiveCount {
            public static boolean isPositive(int value) {
                return value > 0;
            }

            public static int countPositive(int[] items) {
                int count = 0;
                for (int i = 0; i < items.length; i += 1) {
                    if (isPositive(items[i])) {
                        count += 1;
                    }
                }
                return count;
            }

            public static void main(String[] args) {
                int[] data = new int[] {-2, 5, 0, 7};
                System.out.println(countPositive(data));
            }
        }
        """,
        [
            m("isPositive", "boolean isPositive(int value)", "Test whether a number is positive.", "Result is true iff value > 0.", "Single comparison return.", "Postcondition equates result with the comparison."),
            m("countPositive", "int countPositive(int[] items)", "Count positive array values.", "Result is the number of indices containing positive values.", "A bounded loop calls isPositive and conditionally increments.", "Invariant: count matches positives in the scanned prefix."),
        ],
    ),
    ProgramSpec(
        "ArrayNegativeCount",
        "counting negative values in an array",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java",
        ["arrays", "for", "if"],
        """
        public class ArrayNegativeCount {
            public static boolean isNegative(int value) {
                return value < 0;
            }

            public static int countNegative(int[] items) {
                int count = 0;
                for (int i = 0; i < items.length; i += 1) {
                    if (isNegative(items[i])) {
                        count += 1;
                    }
                }
                return count;
            }

            public static void main(String[] args) {
                int[] data = new int[] {-2, 5, -3, 7};
                System.out.println(countNegative(data));
            }
        }
        """,
        [
            m("isNegative", "boolean isNegative(int value)", "Test whether a number is negative.", "Result is true iff value < 0.", "Single comparison return.", "Postcondition equates result with the comparison."),
            m("countNegative", "int countNegative(int[] items)", "Count negative array values.", "Result is the number of indices containing negative values.", "A bounded loop calls isNegative and conditionally increments.", "Invariant: count matches negatives in the scanned prefix."),
        ],
    ),
    ProgramSpec(
        "ArrayZeroCount",
        "counting zero values in an array",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java",
        ["arrays", "for", "if"],
        """
        public class ArrayZeroCount {
            public static boolean isZero(int value) {
                return value == 0;
            }

            public static int countZero(int[] items) {
                int count = 0;
                for (int i = 0; i < items.length; i += 1) {
                    if (isZero(items[i])) {
                        count += 1;
                    }
                }
                return count;
            }

            public static void main(String[] args) {
                int[] data = new int[] {0, 5, 0, 7};
                System.out.println(countZero(data));
            }
        }
        """,
        [
            m("isZero", "boolean isZero(int value)", "Test whether a number is zero.", "Result is true iff value == 0.", "Single equality return.", "Postcondition equates result with the comparison."),
            m("countZero", "int countZero(int[] items)", "Count zero array values.", "Result is the number of zero entries.", "A bounded loop calls isZero and conditionally increments.", "Invariant: count matches zero entries in the scanned prefix."),
        ],
    ),
    ProgramSpec(
        "ArrayCopy",
        "copying arrays without aliasing the input",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "allocation"],
        """
        public class ArrayCopy {
            public static int[] copy(int[] items) {
                int[] result = new int[items.length];
                for (int i = 0; i < items.length; i += 1) {
                    result[i] = items[i];
                }
                return result;
            }

            public static int copyAndSum(int[] items) {
                int[] copied = copy(items);
                int total = 0;
                for (int i = 0; i < copied.length; i += 1) {
                    total += copied[i];
                }
                return total;
            }

            public static void main(String[] args) {
                int[] data = new int[] {3, 1, 4};
                System.out.println(copy(data)[1]);
                System.out.println(copyAndSum(data));
            }
        }
        """,
        [
            m("copy", "int[] copy(int[] items)", "Return a same-length array with the same values.", "For every index i, result[i] = items[i].", "Allocates a new array and fills it with a bounded loop.", "Invariant: copied prefix matches the input prefix."),
            m("copyAndSum", "int copyAndSum(int[] items)", "Sum a copied array.", "Result equals the sum of the original values.", "Calls copy, then sums the copy.", "Postcondition reuses copy extensional equality."),
        ],
    ),
    ProgramSpec(
        "ArrayReverseCopy",
        "reversing an array into a new output",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "allocation"],
        """
        public class ArrayReverseCopy {
            public static int[] reverseCopy(int[] items) {
                int[] result = new int[items.length];
                for (int i = 0; i < items.length; i += 1) {
                    result[i] = items[items.length - i - 1];
                }
                return result;
            }

            public static int firstAfterReverse(int[] items) {
                return reverseCopy(items)[0];
            }

            public static void main(String[] args) {
                int[] data = new int[] {2, 4, 6};
                System.out.println(reverseCopy(data)[0]);
                System.out.println(firstAfterReverse(data));
            }
        }
        """,
        [
            m("reverseCopy", "int[] reverseCopy(int[] items)", "Return a reversed copy of the input.", "For every index i, result[i] = items[length - i - 1].", "A bounded loop writes mirrored indices.", "Invariant: written output prefix equals the corresponding reversed input suffix."),
            m("firstAfterReverse", "int firstAfterReverse(int[] items)", "Read the first item of the reversed copy.", "For nonempty input, result is the last input element.", "Calls reverseCopy then indexes zero.", "Postcondition reuses reverseCopy shape."),
        ],
    ),
    ProgramSpec(
        "ArrayRotateLeft",
        "left rotation of an integer array",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "if", "allocation"],
        """
        public class ArrayRotateLeft {
            public static int[] rotateLeftOne(int[] items) {
                int[] result = new int[items.length];
                for (int i = 0; i < items.length; i += 1) {
                    if (i + 1 < items.length) {
                        result[i] = items[i + 1];
                    } else {
                        result[i] = items[0];
                    }
                }
                return result;
            }

            public static int rotatedFirst(int[] items) {
                return rotateLeftOne(items)[0];
            }

            public static void main(String[] args) {
                int[] data = new int[] {9, 8, 7};
                System.out.println(rotateLeftOne(data)[2]);
                System.out.println(rotatedFirst(data));
            }
        }
        """,
        [
            m("rotateLeftOne", "int[] rotateLeftOne(int[] items)", "Move every element one position left and wrap the first value to the end.", "For nonempty input, result[i] = items[i + 1] except the last result is items[0].", "A bounded loop branches on the last index.", "Invariant: output prefix follows the left-rotation relation."),
            m("rotatedFirst", "int rotatedFirst(int[] items)", "Return the first value after a left rotation.", "For length > 1, result is items[1].", "Calls rotateLeftOne then reads index zero.", "Postcondition reuses rotateLeftOne shape."),
        ],
    ),
    ProgramSpec(
        "ArrayPrefixSums",
        "prefix sums over an integer array",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "allocation", "int arithmetic"],
        """
        public class ArrayPrefixSums {
            public static int[] prefixSums(int[] items) {
                int[] result = new int[items.length];
                int total = 0;
                for (int i = 0; i < items.length; i += 1) {
                    total += items[i];
                    result[i] = total;
                }
                return result;
            }

            public static int finalPrefix(int[] items) {
                int[] sums = prefixSums(items);
                return sums[sums.length - 1];
            }

            public static void main(String[] args) {
                int[] data = new int[] {1, 2, 3};
                System.out.println(prefixSums(data)[2]);
                System.out.println(finalPrefix(data));
            }
        }
        """,
        [
            m("prefixSums", "int[] prefixSums(int[] items)", "Return running totals.", "result[i] equals the sum of items[0..i].", "A bounded loop updates total then writes it.", "Invariant: result prefix stores all completed running sums."),
            m("finalPrefix", "int finalPrefix(int[] items)", "Return the last prefix sum.", "For nonempty input, result is the sum of all items.", "Calls prefixSums then reads the final element.", "Postcondition reuses prefixSums summary."),
        ],
    ),
    ProgramSpec(
        "ArrayPairwiseDiff",
        "pairwise adjacent differences",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "allocation", "int arithmetic"],
        """
        public class ArrayPairwiseDiff {
            public static int[] differences(int[] items) {
                int[] result = new int[items.length - 1];
                for (int i = 0; i < result.length; i += 1) {
                    result[i] = items[i + 1] - items[i];
                }
                return result;
            }

            public static int firstDifference(int[] items) {
                return differences(items)[0];
            }

            public static void main(String[] args) {
                int[] data = new int[] {3, 8, 10};
                System.out.println(differences(data)[1]);
                System.out.println(firstDifference(data));
            }
        }
        """,
        [
            m("differences", "int[] differences(int[] items)", "Return adjacent differences.", "result[i] = items[i + 1] - items[i].", "A bounded loop writes one adjacent difference per output index.", "Invariant: output prefix contains correct adjacent differences."),
            m("firstDifference", "int firstDifference(int[] items)", "Return the first adjacent difference.", "Result is items[1] - items[0].", "Calls differences then reads index zero.", "Postcondition reuses differences summary."),
        ],
    ),
    ProgramSpec(
        "ArrayScale",
        "scaling every value in an array",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "allocation", "int arithmetic"],
        """
        public class ArrayScale {
            public static int[] scale(int[] items, int factor) {
                int[] result = new int[items.length];
                for (int i = 0; i < items.length; i += 1) {
                    result[i] = items[i] * factor;
                }
                return result;
            }

            public static int scaledSum(int[] items, int factor) {
                int[] scaled = scale(items, factor);
                int total = 0;
                for (int i = 0; i < scaled.length; i += 1) {
                    total += scaled[i];
                }
                return total;
            }

            public static void main(String[] args) {
                int[] data = new int[] {2, 3, 4};
                System.out.println(scale(data, 3)[1]);
                System.out.println(scaledSum(data, 2));
            }
        }
        """,
        [
            m("scale", "int[] scale(int[] items, int factor)", "Multiply every array element by a factor.", "For every index i, result[i] = items[i] * factor.", "A bounded loop writes scaled values.", "Invariant: output prefix equals scaled input prefix."),
            m("scaledSum", "int scaledSum(int[] items, int factor)", "Sum the scaled array.", "Result is factor times the sum of input values.", "Calls scale then sums.", "Postcondition reuses scale element relation."),
        ],
    ),
    ProgramSpec(
        "ArrayClamp",
        "clamping values to an inclusive interval",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "if", "allocation"],
        """
        public class ArrayClamp {
            public static int clampValue(int value, int low, int high) {
                if (value < low) {
                    return low;
                }
                if (value > high) {
                    return high;
                }
                return value;
            }

            public static int[] clampAll(int[] items, int low, int high) {
                int[] result = new int[items.length];
                for (int i = 0; i < items.length; i += 1) {
                    result[i] = clampValue(items[i], low, high);
                }
                return result;
            }

            public static void main(String[] args) {
                int[] data = new int[] {-1, 5, 99};
                System.out.println(clampValue(12, 0, 10));
                System.out.println(clampAll(data, 0, 10)[2]);
            }
        }
        """,
        [
            m("clampValue", "int clampValue(int value, int low, int high)", "Limit a value to an interval.", "Result is low, high, or value depending on bounds.", "Two conditionals select the bounded result.", "Postcondition: low <= result <= high when low <= high."),
            m("clampAll", "int[] clampAll(int[] items, int low, int high)", "Clamp every array element.", "result[i] = clampValue(items[i], low, high).", "A bounded loop calls clampValue.", "Invariant: output prefix is pointwise clamped."),
        ],
    ),
    ProgramSpec(
        "ArrayAllPositive",
        "universal positivity check",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java",
        ["arrays", "for", "if", "boolean"],
        """
        public class ArrayAllPositive {
            public static boolean allPositive(int[] items) {
                boolean ok = true;
                for (int i = 0; i < items.length; i += 1) {
                    if (items[i] <= 0) {
                        ok = false;
                    }
                }
                return ok;
            }

            public static int positiveBonus(int[] items) {
                if (allPositive(items)) {
                    return items.length;
                }
                return 0;
            }

            public static void main(String[] args) {
                int[] data = new int[] {1, 2, 3};
                System.out.println(allPositive(data));
                System.out.println(positiveBonus(data));
            }
        }
        """,
        [
            m("allPositive", "boolean allPositive(int[] items)", "Check that every item is positive.", "Result is true iff all entries are greater than zero.", "A bounded loop clears ok when it finds a nonpositive value.", "Invariant: ok implies every scanned value is positive."),
            m("positiveBonus", "int positiveBonus(int[] items)", "Return length when all values are positive.", "Result is items.length iff allPositive(items), otherwise zero.", "Branches on allPositive.", "Postcondition reuses allPositive summary."),
        ],
    ),
    ProgramSpec(
        "ArrayAnyNegative",
        "existential negativity check",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java",
        ["arrays", "for", "if", "boolean"],
        """
        public class ArrayAnyNegative {
            public static boolean anyNegative(int[] items) {
                boolean found = false;
                for (int i = 0; i < items.length; i += 1) {
                    if (items[i] < 0) {
                        found = true;
                    }
                }
                return found;
            }

            public static int negativePenalty(int[] items) {
                if (anyNegative(items)) {
                    return -1;
                }
                return 0;
            }

            public static void main(String[] args) {
                int[] data = new int[] {1, -2, 3};
                System.out.println(anyNegative(data));
                System.out.println(negativePenalty(data));
            }
        }
        """,
        [
            m("anyNegative", "boolean anyNegative(int[] items)", "Check whether any item is negative.", "Result is true iff at least one entry is less than zero.", "A bounded loop sets found when it sees a negative value.", "Invariant: found is equivalent to a negative in the scanned prefix."),
            m("negativePenalty", "int negativePenalty(int[] items)", "Return a penalty when a negative exists.", "Result is -1 iff anyNegative(items), otherwise zero.", "Branches on anyNegative.", "Postcondition reuses anyNegative summary."),
        ],
    ),
    ProgramSpec(
        "ArrayIsSorted",
        "checking nondecreasing array order",
        "Berkeley-CS61B/skeleton-fa25 hw09/tests/TestBSTMap.java",
        ["arrays", "for", "if", "boolean"],
        """
        public class ArrayIsSorted {
            public static boolean isSorted(int[] items) {
                boolean sorted = true;
                for (int i = 1; i < items.length; i += 1) {
                    if (items[i] < items[i - 1]) {
                        sorted = false;
                    }
                }
                return sorted;
            }

            public static int sortedScore(int[] items) {
                if (isSorted(items)) {
                    return items.length;
                }
                return -items.length;
            }

            public static void main(String[] args) {
                int[] data = new int[] {1, 3, 3, 8};
                System.out.println(isSorted(data));
                System.out.println(sortedScore(data));
            }
        }
        """,
        [
            m("isSorted", "boolean isSorted(int[] items)", "Check nondecreasing order.", "Result is true iff adjacent pairs are ordered.", "A bounded loop compares each adjacent pair.", "Invariant: sorted means every scanned adjacent pair is ordered."),
            m("sortedScore", "int sortedScore(int[] items)", "Score an array based on sortedness.", "Result is length for sorted input and negative length otherwise.", "Branches on isSorted.", "Postcondition reuses isSorted summary."),
        ],
    ),
    ProgramSpec(
        "ArrayFirstIndex",
        "linear search for first index",
        "Berkeley-CS61B/skeleton-sp21/lab3/randomizedtest/AListNoResizing.java",
        ["arrays", "for", "if", "search"],
        """
        public class ArrayFirstIndex {
            public static int firstIndexOf(int[] items, int target) {
                int found = -1;
                for (int i = 0; i < items.length; i += 1) {
                    if (found == -1 && items[i] == target) {
                        found = i;
                    }
                }
                return found;
            }

            public static boolean contains(int[] items, int target) {
                return firstIndexOf(items, target) >= 0;
            }

            public static void main(String[] args) {
                int[] data = new int[] {4, 1, 4};
                System.out.println(firstIndexOf(data, 4));
                System.out.println(contains(data, 9));
            }
        }
        """,
        [
            m("firstIndexOf", "int firstIndexOf(int[] items, int target)", "Find the first target index or -1.", "Result is the least matching index, or -1 if none exists.", "A bounded loop records the first match and preserves it.", "Invariant: found is -1 or the first match in the scanned prefix."),
            m("contains", "boolean contains(int[] items, int target)", "Check membership using firstIndexOf.", "Result is true iff firstIndexOf returns a nonnegative index.", "Calls firstIndexOf and compares.", "Postcondition reuses firstIndexOf summary."),
        ],
    ),
    ProgramSpec(
        "ArrayLastIndex",
        "linear search for last index",
        "Berkeley-CS61B/skeleton-sp21/lab3/randomizedtest/AListNoResizing.java",
        ["arrays", "for", "if", "search"],
        """
        public class ArrayLastIndex {
            public static int lastIndexOf(int[] items, int target) {
                int found = -1;
                for (int i = 0; i < items.length; i += 1) {
                    if (items[i] == target) {
                        found = i;
                    }
                }
                return found;
            }

            public static int distanceBetweenFirstAndLast(int[] items, int target) {
                int first = ArrayFirstIndex.firstIndexOf(items, target);
                int last = lastIndexOf(items, target);
                return last - first;
            }

            public static void main(String[] args) {
                int[] data = new int[] {4, 1, 4};
                System.out.println(lastIndexOf(data, 4));
                System.out.println(distanceBetweenFirstAndLast(data, 4));
            }
        }
        """,
        [
            m("lastIndexOf", "int lastIndexOf(int[] items, int target)", "Find the last target index or -1.", "Result is the greatest matching index, or -1 if none exists.", "A bounded loop overwrites found at every match.", "Invariant: found is the last match in the scanned prefix."),
            m("distanceBetweenFirstAndLast", "int distanceBetweenFirstAndLast(int[] items, int target)", "Compute the gap between first and last target occurrence.", "Result is lastIndexOf(items,target) - firstIndexOf(items,target).", "Calls firstIndexOf and lastIndexOf.", "Postcondition reuses both search summaries."),
        ],
    ),
    ProgramSpec(
        "ArrayCountTarget",
        "counting target occurrences",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ListExercises.java",
        ["arrays", "for", "if"],
        """
        public class ArrayCountTarget {
            public static int countTarget(int[] items, int target) {
                int count = 0;
                for (int i = 0; i < items.length; i += 1) {
                    if (items[i] == target) {
                        count += 1;
                    }
                }
                return count;
            }

            public static boolean appearsExactlyOnce(int[] items, int target) {
                return countTarget(items, target) == 1;
            }

            public static void main(String[] args) {
                int[] data = new int[] {2, 2, 5};
                System.out.println(countTarget(data, 2));
                System.out.println(appearsExactlyOnce(data, 5));
            }
        }
        """,
        [
            m("countTarget", "int countTarget(int[] items, int target)", "Count target occurrences.", "Result is the number of indices equal to target.", "A bounded loop conditionally increments.", "Invariant: count is target occurrences in the scanned prefix."),
            m("appearsExactlyOnce", "boolean appearsExactlyOnce(int[] items, int target)", "Check whether target appears once.", "Result is true iff countTarget is one.", "Calls countTarget and compares.", "Postcondition reuses countTarget summary."),
        ],
    ),
    ProgramSpec(
        "ArrayReplaceTarget",
        "copying with target replacement",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "if", "allocation"],
        """
        public class ArrayReplaceTarget {
            public static int[] replace(int[] items, int target, int replacement) {
                int[] result = new int[items.length];
                for (int i = 0; i < items.length; i += 1) {
                    if (items[i] == target) {
                        result[i] = replacement;
                    } else {
                        result[i] = items[i];
                    }
                }
                return result;
            }

            public static int replacedCount(int[] items, int target, int replacement) {
                int[] result = replace(items, target, replacement);
                return ArrayCountTarget.countTarget(result, replacement);
            }

            public static void main(String[] args) {
                int[] data = new int[] {1, 2, 1};
                System.out.println(replace(data, 1, 9)[2]);
                System.out.println(replacedCount(data, 1, 9));
            }
        }
        """,
        [
            m("replace", "int[] replace(int[] items, int target, int replacement)", "Replace each target value in a copy.", "Each output index is replacement when input equals target, otherwise the original value.", "A bounded loop branches per element.", "Invariant: output prefix follows the replacement relation."),
            m("replacedCount", "int replacedCount(int[] items, int target, int replacement)", "Count replacement values after replacing.", "Result counts replacement in replace(items,target,replacement).", "Calls replace then countTarget.", "Postcondition reuses replace and countTarget summaries."),
        ],
    ),
    ProgramSpec(
        "ArrayInterleave",
        "interleaving two equal-length arrays",
        "Berkeley-CS61B/skeleton-fa25 hw03/src/ArrayExercises.java",
        ["arrays", "for", "allocation", "int arithmetic"],
        """
        public class ArrayInterleave {
            public static int[] interleave(int[] left, int[] right) {
                int[] result = new int[left.length * 2];
                for (int i = 0; i < left.length; i += 1) {
                    result[2 * i] = left[i];
                    result[2 * i + 1] = right[i];
                }
                return result;
            }

            public static int interleavedLength(int[] left, int[] right) {
                return interleave(left, right).length;
            }

            public static void main(String[] args) {
                int[] left = new int[] {1, 3};
                int[] right = new int[] {2, 4};
                System.out.println(interleave(left, right)[3]);
                System.out.println(interleavedLength(left, right));
            }
        }
        """,
        [
            m("interleave", "int[] interleave(int[] left, int[] right)", "Alternate values from two arrays.", "result[2*i] = left[i] and result[2*i+1] = right[i].", "A bounded loop writes two output slots per input index.", "Invariant: output prefix contains interleaved pairs for scanned indices."),
            m("interleavedLength", "int interleavedLength(int[] left, int[] right)", "Return the length of the interleaved output.", "Result is 2 * left.length.", "Calls interleave and reads length.", "Postcondition reuses interleave length summary."),
        ],
    ),
    ProgramSpec(
        "MatrixTrace",
        "trace of a square matrix",
        "Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java",
        ["arrays", "nested arrays", "for", "int arithmetic"],
        """
        public class MatrixTrace {
            public static int trace(int[][] matrix) {
                int total = 0;
                for (int i = 0; i < matrix.length; i += 1) {
                    total += matrix[i][i];
                }
                return total;
            }

            public static int tracePlusSize(int[][] matrix) {
                return trace(matrix) + matrix.length;
            }

            public static void main(String[] args) {
                int[][] matrix = new int[][] {{1, 2}, {3, 4}};
                System.out.println(trace(matrix));
                System.out.println(tracePlusSize(matrix));
            }
        }
        """,
        [
            m("trace", "int trace(int[][] matrix)", "Sum the diagonal entries.", "Result is sum(matrix[i][i]).", "A bounded loop reads diagonal cells.", "Invariant: total is the diagonal sum for scanned rows."),
            m("tracePlusSize", "int tracePlusSize(int[][] matrix)", "Add matrix size to its trace.", "Result is trace(matrix) + matrix.length.", "Calls trace and adds length.", "Postcondition reuses trace summary."),
        ],
    ),
    ProgramSpec(
        "MatrixRowSums",
        "row sums of a rectangular matrix",
        "Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java",
        ["arrays", "nested for", "allocation"],
        """
        public class MatrixRowSums {
            public static int[] rowSums(int[][] matrix) {
                int[] result = new int[matrix.length];
                for (int row = 0; row < matrix.length; row += 1) {
                    int total = 0;
                    for (int col = 0; col < matrix[row].length; col += 1) {
                        total += matrix[row][col];
                    }
                    result[row] = total;
                }
                return result;
            }

            public static int firstRowSum(int[][] matrix) {
                return rowSums(matrix)[0];
            }

            public static void main(String[] args) {
                int[][] matrix = new int[][] {{1, 2}, {3, 4}};
                System.out.println(rowSums(matrix)[1]);
                System.out.println(firstRowSum(matrix));
            }
        }
        """,
        [
            m("rowSums", "int[] rowSums(int[][] matrix)", "Compute one sum per matrix row.", "result[row] is the finite sum of matrix[row].", "Nested bounded loops accumulate each row.", "Outer invariant: completed rows have correct sums; inner invariant: total is current row prefix sum."),
            m("firstRowSum", "int firstRowSum(int[][] matrix)", "Return the first row sum.", "Result is sum(matrix[0]).", "Calls rowSums then indexes zero.", "Postcondition reuses rowSums summary."),
        ],
    ),
    ProgramSpec(
        "MatrixColumnSums",
        "column sums of a rectangular matrix",
        "Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java",
        ["arrays", "nested for", "allocation"],
        """
        public class MatrixColumnSums {
            public static int[] columnSums(int[][] matrix) {
                int[] result = new int[matrix[0].length];
                for (int col = 0; col < matrix[0].length; col += 1) {
                    int total = 0;
                    for (int row = 0; row < matrix.length; row += 1) {
                        total += matrix[row][col];
                    }
                    result[col] = total;
                }
                return result;
            }

            public static int firstColumnSum(int[][] matrix) {
                return columnSums(matrix)[0];
            }

            public static void main(String[] args) {
                int[][] matrix = new int[][] {{1, 2}, {3, 4}};
                System.out.println(columnSums(matrix)[1]);
                System.out.println(firstColumnSum(matrix));
            }
        }
        """,
        [
            m("columnSums", "int[] columnSums(int[][] matrix)", "Compute one sum per matrix column.", "result[col] is the finite sum of matrix rows at that column.", "Nested bounded loops accumulate each column.", "Outer invariant: completed columns have correct sums; inner invariant: total is current column prefix sum."),
            m("firstColumnSum", "int firstColumnSum(int[][] matrix)", "Return the first column sum.", "Result is sum over matrix[row][0].", "Calls columnSums then indexes zero.", "Postcondition reuses columnSums summary."),
        ],
    ),
    ProgramSpec(
        "MatrixMax",
        "maximum value in a matrix",
        "Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java",
        ["arrays", "nested for", "if"],
        """
        public class MatrixMax {
            public static int max(int[][] matrix) {
                int best = matrix[0][0];
                for (int row = 0; row < matrix.length; row += 1) {
                    for (int col = 0; col < matrix[row].length; col += 1) {
                        if (matrix[row][col] > best) {
                            best = matrix[row][col];
                        }
                    }
                }
                return best;
            }

            public static boolean firstIsMax(int[][] matrix) {
                return matrix[0][0] == max(matrix);
            }

            public static void main(String[] args) {
                int[][] matrix = new int[][] {{1, 9}, {3, 4}};
                System.out.println(max(matrix));
                System.out.println(firstIsMax(matrix));
            }
        }
        """,
        [
            m("max", "int max(int[][] matrix)", "Find the maximum matrix value.", "Result is an entry greater than or equal to every entry.", "Nested bounded loops update best on larger values.", "Invariant: best is the maximum over scanned cells."),
            m("firstIsMax", "boolean firstIsMax(int[][] matrix)", "Check whether the first cell is maximal.", "Result is true iff matrix[0][0] equals max(matrix).", "Calls max and compares.", "Postcondition reuses max summary."),
        ],
    ),
    ProgramSpec(
        "MatrixAdd",
        "pointwise matrix addition",
        "Berkeley-CS61B/skeleton-sp24/proj3/src/core/World.java",
        ["arrays", "nested for", "allocation", "int arithmetic"],
        """
        public class MatrixAdd {
            public static int[][] add(int[][] left, int[][] right) {
                int[][] result = new int[left.length][left[0].length];
                for (int row = 0; row < left.length; row += 1) {
                    for (int col = 0; col < left[row].length; col += 1) {
                        result[row][col] = left[row][col] + right[row][col];
                    }
                }
                return result;
            }

            public static int topLeftSum(int[][] left, int[][] right) {
                return add(left, right)[0][0];
            }

            public static void main(String[] args) {
                int[][] left = new int[][] {{1, 2}, {3, 4}};
                int[][] right = new int[][] {{5, 6}, {7, 8}};
                System.out.println(add(left, right)[1][1]);
                System.out.println(topLeftSum(left, right));
            }
        }
        """,
        [
            m("add", "int[][] add(int[][] left, int[][] right)", "Add two matrices pointwise.", "result[row][col] = left[row][col] + right[row][col].", "Nested bounded loops write pointwise sums.", "Invariant: completed cells satisfy pointwise addition."),
            m("topLeftSum", "int topLeftSum(int[][] left, int[][] right)", "Read the top-left pointwise sum.", "Result is left[0][0] + right[0][0].", "Calls add then reads [0][0].", "Postcondition reuses add summary."),
        ],
    ),
    ProgramSpec(
        "StringVowelCount",
        "counting vowels in a string",
        "Berkeley-CS61B/skeleton-fa25 hw02/src/PrintIndexed.java",
        ["strings", "for", "if", "function calls"],
        """
        public class StringVowelCount {
            public static boolean isVowel(char c) {
                return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
            }

            public static int countVowels(String text) {
                int count = 0;
                for (int i = 0; i < text.length(); i += 1) {
                    if (isVowel(text.charAt(i))) {
                        count += 1;
                    }
                }
                return count;
            }

            public static void main(String[] args) {
                System.out.println(isVowel('e'));
                System.out.println(countVowels("strata"));
            }
        }
        """,
        [
            m("isVowel", "boolean isVowel(char c)", "Classify lowercase vowels.", "Result is true iff c is one of a,e,i,o,u.", "Boolean expression return.", "Postcondition enumerates the vowel cases."),
            m("countVowels", "int countVowels(String text)", "Count vowels in text.", "Result is the number of character positions classified as vowels.", "A bounded loop calls isVowel.", "Invariant: count is vowels in the scanned prefix."),
        ],
    ),
    ProgramSpec(
        "StringMirror",
        "mirroring a string around itself",
        "Berkeley-CS61B/skeleton-fa25 hw02/src/DoubleUp.java",
        ["strings", "for", "StringBuilder"],
        """
        public class StringMirror {
            public static String reverse(String text) {
                StringBuilder builder = new StringBuilder();
                for (int i = text.length() - 1; i >= 0; i -= 1) {
                    builder.append(text.charAt(i));
                }
                return builder.toString();
            }

            public static String mirror(String text) {
                return text + reverse(text);
            }

            public static void main(String[] args) {
                System.out.println(reverse("abc"));
                System.out.println(mirror("ab"));
            }
        }
        """,
        [
            m("reverse", "String reverse(String text)", "Return characters in reverse order.", "For length n, result[i] = text[n - i - 1].", "A bounded descending for loop appends characters.", "Invariant: output prefix matches reversed input suffix."),
            m("mirror", "String mirror(String text)", "Append the reverse of text to text.", "Result is text concatenated with reverse(text).", "Calls reverse and concatenates.", "Postcondition reuses reverse summary."),
        ],
    ),
    ProgramSpec(
        "StringIsPalindrome",
        "palindrome checking by mirrored indices",
        "Berkeley-CS61B/skeleton-fa25 hw06/src/adventure/PalindromeStage.java",
        ["strings", "for", "if", "boolean"],
        """
        public class StringIsPalindrome {
            public static boolean isPalindrome(String text) {
                boolean ok = true;
                for (int i = 0; i < text.length(); i += 1) {
                    if (text.charAt(i) != text.charAt(text.length() - i - 1)) {
                        ok = false;
                    }
                }
                return ok;
            }

            public static int palindromeScore(String text) {
                if (isPalindrome(text)) {
                    return text.length();
                }
                return 0;
            }

            public static void main(String[] args) {
                System.out.println(isPalindrome("level"));
                System.out.println(palindromeScore("java"));
            }
        }
        """,
        [
            m("isPalindrome", "boolean isPalindrome(String text)", "Check mirrored character equality.", "Result is true iff every position equals its mirror.", "A bounded loop clears ok on a mismatch.", "Invariant: ok means all scanned mirrored pairs match."),
            m("palindromeScore", "int palindromeScore(String text)", "Score palindromes by length.", "Result is length iff isPalindrome is true, otherwise zero.", "Branches on isPalindrome.", "Postcondition reuses isPalindrome summary."),
        ],
    ),
    ProgramSpec(
        "StringRemoveSpaces",
        "removing spaces from a string",
        "Berkeley-CS61B/skeleton-fa25 hw02/src/DoubleUp.java",
        ["strings", "for", "if", "StringBuilder"],
        """
        public class StringRemoveSpaces {
            public static String removeSpaces(String text) {
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < text.length(); i += 1) {
                    if (text.charAt(i) != ' ') {
                        builder.append(text.charAt(i));
                    }
                }
                return builder.toString();
            }

            public static int compactLength(String text) {
                return removeSpaces(text).length();
            }

            public static void main(String[] args) {
                System.out.println(removeSpaces("a b c"));
                System.out.println(compactLength("a b c"));
            }
        }
        """,
        [
            m("removeSpaces", "String removeSpaces(String text)", "Drop space characters.", "Result is the subsequence of non-space input characters.", "A bounded loop appends only non-space characters.", "Invariant: output prefix is the non-space projection of the scanned prefix."),
            m("compactLength", "int compactLength(String text)", "Return the length after removing spaces.", "Result is the count of non-space input characters.", "Calls removeSpaces and reads length.", "Postcondition reuses removeSpaces shape."),
        ],
    ),
    ProgramSpec(
        "StringFirstDifference",
        "first differing character position",
        "Berkeley-CS61B/skeleton-fa25 hw02/src/PrintIndexed.java",
        ["strings", "for", "if", "search"],
        """
        public class StringFirstDifference {
            public static int firstDifference(String left, String right) {
                int found = -1;
                for (int i = 0; i < left.length(); i += 1) {
                    if (found == -1 && left.charAt(i) != right.charAt(i)) {
                        found = i;
                    }
                }
                return found;
            }

            public static boolean samePrefix(String left, String right) {
                return firstDifference(left, right) == -1;
            }

            public static void main(String[] args) {
                System.out.println(firstDifference("abcd", "abed"));
                System.out.println(samePrefix("abc", "abc"));
            }
        }
        """,
        [
            m("firstDifference", "int firstDifference(String left, String right)", "Find the first differing index.", "Result is the least index where characters differ, or -1 if none in the scanned length.", "A bounded loop records the first mismatch.", "Invariant: found is -1 or the first mismatch in the scanned prefix."),
            m("samePrefix", "boolean samePrefix(String left, String right)", "Check whether no difference was found.", "Result is true iff firstDifference returns -1.", "Calls firstDifference and compares.", "Postcondition reuses firstDifference summary."),
        ],
    ),
    ProgramSpec(
        "StringRunCount",
        "counting runs of equal adjacent characters",
        "Berkeley-CS61B/skeleton-fa25 hw02/src/PrintIndexed.java",
        ["strings", "for", "if"],
        """
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
        """,
        [
            m("runCount", "int runCount(String text)", "Count maximal equal-character runs.", "Result is one plus the number of adjacent changes for nonempty text.", "A bounded loop increments at run starts.", "Invariant: runs counts run starts in the scanned prefix."),
            m("hasOneRun", "boolean hasOneRun(String text)", "Check whether text has exactly one run.", "Result is true iff runCount(text) is one.", "Calls runCount and compares.", "Postcondition reuses runCount summary."),
        ],
    ),
    ProgramSpec(
        "StringRepeatEach",
        "repeating every character a fixed number of times",
        "Berkeley-CS61B/skeleton-fa25 hw02/src/DoubleUp.java",
        ["strings", "nested for", "StringBuilder"],
        """
        public class StringRepeatEach {
            public static String repeatEach(String text, int times) {
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < text.length(); i += 1) {
                    for (int j = 0; j < times; j += 1) {
                        builder.append(text.charAt(i));
                    }
                }
                return builder.toString();
            }

            public static int repeatedLength(String text, int times) {
                return repeatEach(text, times).length();
            }

            public static void main(String[] args) {
                System.out.println(repeatEach("ab", 3));
                System.out.println(repeatedLength("abc", 2));
            }
        }
        """,
        [
            m("repeatEach", "String repeatEach(String text, int times)", "Repeat each character times times.", "For times >= 0, result length is text.length() * times.", "Nested bounded loops append repetitions.", "Invariant: output contains completed repeated character blocks."),
            m("repeatedLength", "int repeatedLength(String text, int times)", "Return repeatEach output length.", "Result is text.length() * times for times >= 0.", "Calls repeatEach and reads length.", "Postcondition reuses repeatEach length summary."),
        ],
    ),
    ProgramSpec(
        "NumberDigitSum",
        "digit sum with bounded decimal places",
        "Berkeley-CS61B/skeleton-sp21/lab1/HelloNumbers.java",
        ["for", "if", "int arithmetic"],
        """
        public class NumberDigitSum {
            public static int digitSumUpToSix(int value) {
                int n = value;
                int total = 0;
                for (int i = 0; i < 6; i += 1) {
                    total += n % 10;
                    n = n / 10;
                }
                return total;
            }

            public static boolean digitSumEven(int value) {
                return digitSumUpToSix(value) % 2 == 0;
            }

            public static void main(String[] args) {
                System.out.println(digitSumUpToSix(12345));
                System.out.println(digitSumEven(222));
            }
        }
        """,
        [
            m("digitSumUpToSix", "int digitSumUpToSix(int value)", "Sum up to six decimal digits.", "Result is the sum of six low-order base-10 digits.", "A fixed six-iteration loop extracts one digit per step.", "Invariant: total is the sum of digits already extracted."),
            m("digitSumEven", "boolean digitSumEven(int value)", "Check parity of the bounded digit sum.", "Result is true iff digitSumUpToSix(value) is even.", "Calls digitSumUpToSix and checks parity.", "Postcondition reuses digitSumUpToSix summary."),
        ],
    ),
    ProgramSpec(
        "NumberFactorialBounded",
        "factorial by bounded multiplication",
        "Berkeley-CS61B/skeleton-sp21/lab1/HelloNumbers.java",
        ["for", "int arithmetic"],
        """
        public class NumberFactorialBounded {
            public static int factorial(int n) {
                int result = 1;
                for (int i = 2; i <= n; i += 1) {
                    result *= i;
                }
                return result;
            }

            public static int factorialPlusOne(int n) {
                return factorial(n) + 1;
            }

            public static void main(String[] args) {
                System.out.println(factorial(5));
                System.out.println(factorialPlusOne(4));
            }
        }
        """,
        [
            m("factorial", "int factorial(int n)", "Compute n factorial for nonnegative n.", "Result is the product of integers 2..n.", "A bounded for loop multiplies the accumulator.", "Invariant after i: result is product 2..i-1."),
            m("factorialPlusOne", "int factorialPlusOne(int n)", "Add one to factorial.", "Result is factorial(n) + 1.", "Calls factorial and adds one.", "Postcondition reuses factorial summary."),
        ],
    ),
    ProgramSpec(
        "NumberFibonacciBounded",
        "iterative Fibonacci computation",
        "Berkeley-CS61B/skeleton-sp21/lab1/HelloNumbers.java",
        ["for", "if", "int arithmetic"],
        """
        public class NumberFibonacciBounded {
            public static int fibonacci(int n) {
                int previous = 0;
                int current = 1;
                for (int i = 0; i < n; i += 1) {
                    int next = previous + current;
                    previous = current;
                    current = next;
                }
                return previous;
            }

            public static boolean fibonacciIsEven(int n) {
                return fibonacci(n) % 2 == 0;
            }

            public static void main(String[] args) {
                System.out.println(fibonacci(7));
                System.out.println(fibonacciIsEven(6));
            }
        }
        """,
        [
            m("fibonacci", "int fibonacci(int n)", "Compute the nth Fibonacci number iteratively.", "For n >= 0, result is Fib(n).", "A bounded loop advances previous/current state.", "Invariant: previous = Fib(i) and current = Fib(i + 1)."),
            m("fibonacciIsEven", "boolean fibonacciIsEven(int n)", "Check parity of Fibonacci output.", "Result is true iff fibonacci(n) is even.", "Calls fibonacci and checks parity.", "Postcondition reuses fibonacci summary."),
        ],
    ),
    ProgramSpec(
        "NumberIsPrimeBounded",
        "bounded primality check by trial division",
        "Berkeley-CS61B/skeleton-sp21/lab2/IntList/Primes.java",
        ["for", "if", "int arithmetic"],
        """
        public class NumberIsPrimeBounded {
            public static boolean isPrime(int n) {
                boolean prime = n >= 2;
                for (int d = 2; d < n; d += 1) {
                    if (n % d == 0) {
                        prime = false;
                    }
                }
                return prime;
            }

            public static int primeBonus(int n) {
                if (isPrime(n)) {
                    return n;
                }
                return 0;
            }

            public static void main(String[] args) {
                System.out.println(isPrime(13));
                System.out.println(primeBonus(12));
            }
        }
        """,
        [
            m("isPrime", "boolean isPrime(int n)", "Check whether n is prime by bounded trial division.", "Result is true iff n >= 2 and no divisor d in 2..n-1 divides n.", "A bounded loop clears prime when it finds a divisor.", "Invariant: prime means no scanned divisor divides n."),
            m("primeBonus", "int primeBonus(int n)", "Return n only when prime.", "Result is n iff isPrime(n), otherwise zero.", "Branches on isPrime.", "Postcondition reuses isPrime summary."),
        ],
    ),
    ProgramSpec(
        "NumberDivisorCount",
        "counting positive divisors",
        "Berkeley-CS61B/skeleton-sp21/lab2/IntList/Primes.java",
        ["for", "if", "int arithmetic"],
        """
        public class NumberDivisorCount {
            public static int divisorCount(int n) {
                int count = 0;
                for (int d = 1; d <= n; d += 1) {
                    if (n % d == 0) {
                        count += 1;
                    }
                }
                return count;
            }

            public static boolean hasTwoDivisors(int n) {
                return divisorCount(n) == 2;
            }

            public static void main(String[] args) {
                System.out.println(divisorCount(12));
                System.out.println(hasTwoDivisors(13));
            }
        }
        """,
        [
            m("divisorCount", "int divisorCount(int n)", "Count positive divisors up to n.", "Result is the number of d in 1..n such that d divides n.", "A bounded loop conditionally increments on divisibility.", "Invariant: count is divisors in the scanned range."),
            m("hasTwoDivisors", "boolean hasTwoDivisors(int n)", "Check whether exactly two divisors exist.", "Result is true iff divisorCount(n) is two.", "Calls divisorCount and compares.", "Postcondition reuses divisorCount summary."),
        ],
    ),
    ProgramSpec(
        "NumberGcdByScan",
        "greatest common divisor by bounded scan",
        "Berkeley-CS61B/skeleton-sp21/lab2/IntList/Primes.java",
        ["for", "if", "int arithmetic"],
        """
        public class NumberGcdByScan {
            public static int gcdByScan(int a, int b) {
                int limit = a;
                if (b < limit) {
                    limit = b;
                }
                int best = 1;
                for (int d = 1; d <= limit; d += 1) {
                    if (a % d == 0 && b % d == 0) {
                        best = d;
                    }
                }
                return best;
            }

            public static boolean relativelyPrime(int a, int b) {
                return gcdByScan(a, b) == 1;
            }

            public static void main(String[] args) {
                System.out.println(gcdByScan(12, 18));
                System.out.println(relativelyPrime(8, 15));
            }
        }
        """,
        [
            m("gcdByScan", "int gcdByScan(int a, int b)", "Find the greatest common divisor by scanning candidates.", "Result is the largest d <= min(a,b) dividing both inputs.", "A bounded loop overwrites best on common divisors.", "Invariant: best is the largest common divisor seen so far."),
            m("relativelyPrime", "boolean relativelyPrime(int a, int b)", "Check whether gcd is one.", "Result is true iff gcdByScan(a,b) == 1.", "Calls gcdByScan and compares.", "Postcondition reuses gcdByScan summary."),
        ],
    ),
    ProgramSpec(
        "SelectionSortCopy",
        "selection sort into a copied array",
        "Berkeley-CS61B/skeleton-fa25 hw09/tests/StringUtils.java",
        ["arrays", "nested for", "if", "mutation"],
        """
        public class SelectionSortCopy {
            public static int[] sortedCopy(int[] items) {
                int[] result = ArrayCopy.copy(items);
                for (int i = 0; i < result.length; i += 1) {
                    int best = i;
                    for (int j = i + 1; j < result.length; j += 1) {
                        if (result[j] < result[best]) {
                            best = j;
                        }
                    }
                    int temp = result[i];
                    result[i] = result[best];
                    result[best] = temp;
                }
                return result;
            }

            public static int smallest(int[] items) {
                return sortedCopy(items)[0];
            }

            public static void main(String[] args) {
                int[] data = new int[] {4, 1, 3};
                System.out.println(sortedCopy(data)[0]);
                System.out.println(smallest(data));
            }
        }
        """,
        [
            m("sortedCopy", "int[] sortedCopy(int[] items)", "Return a sorted copy using selection sort.", "Output is sorted and is a permutation of input.", "Nested bounded loops select a minimum and swap.", "Invariant: prefix before i is sorted and contains the i smallest values."),
            m("smallest", "int smallest(int[] items)", "Return the smallest value via sortedCopy.", "For nonempty input, result is the minimum input value.", "Calls sortedCopy then reads index zero.", "Postcondition reuses sortedCopy sortedness/permutation facts."),
        ],
    ),
    ProgramSpec(
        "StackArrayCounter",
        "small bounded array-backed stack counter",
        "Berkeley-CS61B/skeleton-fa25 hw05/tests/TestStack.java",
        ["arrays", "for", "if", "object methods"],
        """
        public class StackArrayCounter {
            private int[] values;
            private int size;

            public StackArrayCounter(int capacity) {
                values = new int[capacity];
                size = 0;
            }

            public boolean push(int value) {
                if (size < values.length) {
                    values[size] = value;
                    size += 1;
                    return true;
                }
                return false;
            }

            public int sum() {
                int total = 0;
                for (int i = 0; i < size; i += 1) {
                    total += values[i];
                }
                return total;
            }

            public int size() {
                return size;
            }

            public static int demo() {
                StackArrayCounter stack = new StackArrayCounter(3);
                stack.push(5);
                stack.push(7);
                return stack.sum() + stack.size();
            }

            public static void main(String[] args) {
                System.out.println(demo());
            }
        }
        """,
        [
            m("push", "boolean push(int value)", "Push a value if capacity remains.", "Result is true iff size grows by one and the value is stored.", "A conditional updates array and size or leaves state unchanged.", "Frame condition: only values[size] and size change on success."),
            m("sum", "int sum()", "Sum stack contents up to size.", "Result is the sum of values[0..size-1].", "A bounded loop accumulates stored values.", "Invariant: total is sum of scanned stack prefix."),
            m("size", "int size()", "Return the current stack size.", "Result equals the private size field.", "Single return step.", "Postcondition exposes the size field."),
            m("demo", "int demo()", "Run a fixed stack sequence.", "Result is 14 for pushes 5 and 7 plus size 2.", "Allocates a stack, pushes two values, then calls sum and size.", "Postcondition reuses push, sum, and size summaries."),
        ],
    ),
]


def normalize_source(source: str) -> str:
    return dedent(source).strip() + "\n"


def load_json(path: Path) -> dict[str, Any]:
    with path.open(encoding="utf-8") as handle:
        value = json.load(handle)
    if not isinstance(value, dict):
        raise TypeError(f"{path} must contain a JSON object")
    return value


def write_json(path: Path, value: dict[str, Any]) -> None:
    path.write_text(json.dumps(value, indent=2) + "\n", encoding="utf-8")


def target_name(class_name: str, method_name: str) -> str:
    return f"{class_name}_{method_name}"


def update_sources() -> None:
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for program in PROGRAMS:
        (SRC_DIR / f"{program.class_name}.java").write_text(
            normalize_source(program.source),
            encoding="utf-8",
        )


def update_metadata() -> None:
    metadata = load_json(METADATA)
    metadata["name"] = "cs61b-java-small-v2-50"
    metadata["purpose"] = (
        "Fifty Java corpus programs for Strata experiments, using CS 61B-style "
        "topics while staying in a small loop/if/function-call subset."
    )
    metadata["source_policy"] = (
        "The v1 programs are original StrataJava examples. Public Berkeley-CS61B "
        "repositories were scraped to choose representative topics and record "
        "source probes. Alok clarified that verbatim public CS 61B examples are "
        "acceptable for future corpus expansion; v2 expands with original "
        "buildable CS61B-style samples while keeping source probes."
    )

    existing = {program["file"]: program for program in metadata["programs"]}
    for program in PROGRAMS:
        file_name = f"corpus/cs61b-java/src/{program.class_name}.java"
        existing[file_name] = {
            "file": file_name,
            "topic": program.topic,
            "source_probe": program.source_probe,
            "features": program.features,
        }

    metadata["programs"] = [existing[key] for key in sorted(existing)]
    write_json(METADATA, metadata)


def semantic_card(program: ProgramSpec) -> dict[str, Any]:
    return {
        "source_file": f"corpus/cs61b-java/src/{program.class_name}.java",
        "class": program.class_name,
        "program_semantics": (
            f"CS61B-style sample for {program.topic}. The chain keeps source, "
            "surface intent, functional relation, operational loop/call story, "
            "verification obligation, and Strata target aligned."
        ),
        "methods": [
            {
                "name": method.name,
                "signature": method.signature,
                "layers": {
                    "surface": method.surface,
                    "functional": method.functional,
                    "operational": method.operational,
                    "verification": method.verification,
                    "strata_core": target_name(program.class_name, method.name),
                },
            }
            for method in program.methods
        ],
    }


def update_semantics() -> None:
    semantics = load_json(SEMANTICS)
    semantics["intent"] = (
        "Attach stackable, chained semantics to each Java corpus program: source, "
        "surface summary, functional relation, operational story, verification "
        "obligations, and a Strata Core sketch target. The corpus currently has "
        "50 buildable Java programs."
    )
    existing = {program["source_file"]: program for program in semantics["programs"]}
    for program in PROGRAMS:
        card = semantic_card(program)
        existing[card["source_file"]] = card
    semantics["programs"] = [existing[key] for key in sorted(existing)]
    write_json(SEMANTICS, semantics)


def update_core_sketch() -> None:
    marker = "// Generated lightweight expansion targets for the 50-file corpus."
    text = CORE_SKETCH.read_text(encoding="utf-8").rstrip()
    if marker in text:
        text = text.split(marker, 1)[0].rstrip()

    lines = ["", marker]
    for program in PROGRAMS:
        for method in program.methods:
            proc = target_name(program.class_name, method.name)
            label = f"{proc}_chain"
            lines.extend(
                [
                    "",
                    f"procedure {proc}()",
                    f"spec {{ ensures [{label}]: true; }}",
                    "{ assume true; };",
                ]
            )
    CORE_SKETCH.write_text(text + "\n" + "\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    update_sources()
    update_metadata()
    update_semantics()
    update_core_sketch()
    print(f"Expanded corpus with {len(PROGRAMS)} additional Java programs.")


if __name__ == "__main__":
    main()
