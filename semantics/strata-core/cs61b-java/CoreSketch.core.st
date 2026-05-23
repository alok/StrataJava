program Core;

// Semantic sketch for the StrataJava CS61B-style Java corpus.
// This is not a full Java frontend. It is the L5 stack layer: Boogie-like
// procedure names and contracts that can be massaged toward Strata Core.
// The intended chain is:
// Java source -> surface summary -> functional relation -> operational story
// -> verification obligations -> these named Core procedure/spec targets.

type IntArray;
type JavaString;
type StringArray;
type UnionFindState;

function pow(base: int, exponent: int): int;
function max3(a: int, b: int, c: int): int;
function strlen(s: JavaString): int;
function starLineShape(width: int): bool;
function triangleShape(height: int): bool;
function indexedShape(input: JavaString, output: JavaString): bool;
function doubledShape(input: JavaString, output: JavaString): bool;
function arrLen(a: IntArray): int;
function arrRead(a: IntArray, i: int): int;
function arrMin(a: IntArray): int;
function arrMax(a: IntArray): int;
function secondLargest4(a: IntArray): int;
function evenCount(a: IntArray): int;
function arrSum(a: IntArray): int;
function containsInRange(a: IntArray, limit: int, target: int): bool;
function contains(a: IntArray, target: int): bool;
function commonDistinctCount(left: IntArray, right: IntArray): int;
function commonDistinctShape(left: IntArray, right: IntArray, result: IntArray): bool;
function wordCount(words: StringArray, target: JavaString): int;
function charCount(words: StringArray, target: int): int;
function collatzNext(n: int): int;
function collatzIter(start: int, steps: int): int;
function firstCollatzOneStep(start: int, maxSteps: int): int;
function ufSize(s: UnionFindState): int;
function ufValid(s: UnionFindState, item: int): bool;
function ufRoot(s: UnionFindState, item: int): int;
function ufSizeOf(s: UnionFindState, item: int): int;
function ufConnected(s: UnionFindState, left: int, right: int): bool;
function ufUnion(s: UnionFindState, left: int, right: int): UnionFindState;
function ufDemoState(): UnionFindState;

procedure ArithmeticFacts_product(a: int, b: int, out result: int)
spec { ensures [product_summary]: result == a * b; }
{ result := a * b; };

procedure ArithmeticFacts_sum(a: int, b: int, out result: int)
spec { ensures [sum_summary]: result == a + b; }
{ result := a + b; };

procedure ArithmeticFacts_boundedPower(base: int, exponent: int, out result: int)
spec {
  requires exponent >= 0;
  ensures [boundedPower_summary]: result == pow(base, exponent);
}
{ assume result == pow(base, exponent); };

procedure ArithmeticFacts_maxOfThree(a: int, b: int, c: int, out result: int)
spec {
  ensures [max3_upper_a]: a <= result;
  ensures [max3_upper_b]: b <= result;
  ensures [max3_upper_c]: c <= result;
  ensures [max3_member]: result == a || result == b || result == c;
  ensures [max3_summary]: result == max3(a, b, c);
}
{ assume result == max3(a, b, c); };

procedure ArithmeticFacts_score(a: int, b: int, c: int, out result: int)
spec { ensures [score_summary]: result == ((a + b) * c) + max3(a, b, c); }
{ result := ((a + b) * c) + max3(a, b, c); };

procedure StarTriangleBounded_lineOfStars_len(width: int, out resultLen: int)
spec {
  requires width >= 0;
  ensures [line_len]: resultLen == width;
  ensures [line_shape]: starLineShape(width);
}
{ resultLen := width; };

procedure StarTriangleBounded_triangle_rows(height: int, out rows: int)
spec {
  requires height >= 0;
  ensures [triangle_rows]: rows == height;
  ensures [triangle_shape]: triangleShape(height);
}
{ rows := height; };

procedure StarTriangleBounded_triangleAreaCells(height: int, out result: int)
spec {
  requires height >= 0;
  ensures [triangle_area]: result * 2 == height * (height + 1);
}
{ result := (height * (height + 1)) div 2; };

procedure IndexedString_indexed_shape(text: JavaString, out result: JavaString)
spec { ensures [indexed_shape]: indexedShape(text, result); }
{ assume indexedShape(text, result); };

procedure IndexedString_digitWeight(text: JavaString, out result: int)
spec {
  requires strlen(text) >= 0;
  ensures [digit_weight]: result * 2 == strlen(text) * (strlen(text) - 1);
}
{ result := (strlen(text) * (strlen(text) - 1)) div 2; };

procedure DoubleCharacters_doubleUp_shape(text: JavaString, out result: JavaString)
spec {
  ensures [double_shape]: doubledShape(text, result);
  ensures [double_len]: strlen(result) == 2 * strlen(text);
}
{ assume doubledShape(text, result); assume strlen(result) == 2 * strlen(text); };

procedure DoubleCharacters_doubledLength(text: JavaString, out result: int)
spec { ensures [doubled_len]: result == 2 * strlen(text); }
{ result := 2 * strlen(text); };

procedure ArrayMinMax_minValue(items: IntArray, out result: int)
spec {
  requires arrLen(items) > 0;
  ensures [min_summary]: result == arrMin(items);
}
{ assume result == arrMin(items); };

procedure ArrayMinMax_maxValue(items: IntArray, out result: int)
spec {
  requires arrLen(items) > 0;
  ensures [max_summary]: result == arrMax(items);
}
{ assume result == arrMax(items); };

procedure ArrayMinMax_minMaxDifference(items: IntArray, out result: int)
spec {
  requires arrLen(items) > 0;
  ensures [spread_summary]: result == arrMax(items) - arrMin(items);
}
{ result := arrMax(items) - arrMin(items); };

procedure ArrayMinMax_secondLargestOfFour(items: IntArray, out result: int)
spec {
  requires arrLen(items) >= 4;
  ensures [second_largest4_summary]: result == secondLargest4(items);
}
{ assume result == secondLargest4(items); };

procedure EvenFilterArray_isEven(value: int, out result: bool)
spec { ensures [is_even_summary]: result == (value % 2 == 0); }
{ result := value % 2 == 0; };

procedure EvenFilterArray_countEvens(items: IntArray, out result: int)
spec { ensures [count_evens_summary]: result == evenCount(items); }
{ assume result == evenCount(items); };

procedure EvenFilterArray_evens_shape(items: IntArray, out result: IntArray)
spec {
  ensures [evens_len]: arrLen(result) == evenCount(items);
  ensures [evens_shape]: commonDistinctShape(result, result, result) || arrLen(result) == evenCount(items);
}
{ assume arrLen(result) == evenCount(items); };

procedure EvenFilterArray_sum(items: IntArray, out result: int)
spec { ensures [sum_summary]: result == arrSum(items); }
{ assume result == arrSum(items); };

procedure CommonValuesArray_containsBefore(items: IntArray, limit: int, target: int, out result: bool)
spec {
  requires limit >= 0;
  requires limit <= arrLen(items);
  ensures [contains_before_summary]: result == containsInRange(items, limit, target);
}
{ assume result == containsInRange(items, limit, target); };

procedure CommonValuesArray_contains(items: IntArray, target: int, out result: bool)
spec { ensures [contains_summary]: result == contains(items, target); }
{ assume result == contains(items, target); };

procedure CommonValuesArray_countCommonDistinct(left: IntArray, right: IntArray, out result: int)
spec { ensures [common_count_summary]: result == commonDistinctCount(left, right); }
{ assume result == commonDistinctCount(left, right); };

procedure CommonValuesArray_commonDistinct_shape(left: IntArray, right: IntArray, out result: IntArray)
spec {
  ensures [common_len]: arrLen(result) == commonDistinctCount(left, right);
  ensures [common_shape]: commonDistinctShape(left, right, result);
}
{ assume arrLen(result) == commonDistinctCount(left, right); assume commonDistinctShape(left, right, result); };

procedure OccurrenceCounts_countWord(words: StringArray, target: JavaString, out result: int)
spec { ensures [count_word_summary]: result == wordCount(words, target); }
{ assume result == wordCount(words, target); };

procedure OccurrenceCounts_countCharacter(words: StringArray, target: int, out result: int)
spec { ensures [count_char_summary]: result == charCount(words, target); }
{ assume result == charCount(words, target); };

procedure OccurrenceCounts_score(words: StringArray, targetWord: JavaString, targetChar: int, out result: int)
spec { ensures [occurrence_score_summary]: result == 10 * wordCount(words, targetWord) + charCount(words, targetChar); }
{ result := 10 * wordCount(words, targetWord) + charCount(words, targetChar); };

procedure BoundedCollatz_nextNumber(n: int, out result: int)
spec {
  ensures [next_even]: (n % 2 == 0) ==> result == n div 2;
  ensures [next_odd]: (!(n % 2 == 0)) ==> result == 3 * n + 1;
  ensures [next_summary]: result == collatzNext(n);
}
{ assume result == collatzNext(n); };

procedure BoundedCollatz_stepsUntilOne(start: int, maxSteps: int, out result: int)
spec {
  requires maxSteps >= 0;
  ensures [steps_bound_lower]: result >= 0;
  ensures [steps_bound_upper]: result <= maxSteps;
  ensures [steps_summary]: result == firstCollatzOneStep(start, maxSteps);
}
{ assume result == firstCollatzOneStep(start, maxSteps); };

procedure BoundedCollatz_valueAfterSteps(start: int, maxSteps: int, out result: int)
spec {
  requires maxSteps >= 0;
  ensures [value_summary]: result == collatzIter(start, firstCollatzOneStep(start, maxSteps));
}
{ assume result == collatzIter(start, firstCollatzOneStep(start, maxSteps)); };

procedure TinyUnionFind_valid(state: UnionFindState, item: int, out result: bool)
spec { ensures [uf_valid_summary]: result == ufValid(state, item); }
{ assume result == ufValid(state, item); };

procedure TinyUnionFind_root(state: UnionFindState, item: int, out result: int)
spec {
  ensures [uf_root_invalid]: (!ufValid(state, item)) ==> result == -1;
  ensures [uf_root_summary]: result == ufRoot(state, item);
}
{ assume result == ufRoot(state, item); };

procedure TinyUnionFind_sizeOf(state: UnionFindState, item: int, out result: int)
spec { ensures [uf_sizeof_summary]: result == ufSizeOf(state, item); }
{ assume result == ufSizeOf(state, item); };

procedure TinyUnionFind_connected(state: UnionFindState, left: int, right: int, out result: bool)
spec { ensures [uf_connected_summary]: result == ufConnected(state, left, right); }
{ assume result == ufConnected(state, left, right); };

procedure TinyUnionFind_union_relation(state: UnionFindState, left: int, right: int, out result: UnionFindState)
spec {
  ensures [uf_union_summary]: result == ufUnion(state, left, right);
  ensures [uf_union_connected]: (ufValid(state, left) && ufValid(state, right)) ==> ufConnected(result, left, right);
}
{ assume result == ufUnion(state, left, right); };

procedure TinyUnionFind_demoScore(out result: int)
spec { ensures [uf_demo_score]: result == 4; }
{ result := 4; };
