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
function max3(a : int, b : int, c : int) : int {
  if a >= b && a >= c then a else if b >= c then b else c
}
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
function collatzNext(n : int) : int {
  if n % 2 == 0 then n div 2 else 3 * n + 1
}
function collatzIter(start: int, steps: int): int;
function firstCollatzOneStep(start: int, maxSteps: int): int;
function ufSize(s: UnionFindState): int;
function ufValid(s: UnionFindState, item: int): bool;
function ufRoot(s: UnionFindState, item: int): int;
function ufSizeOf(s: UnionFindState, item: int): int;
function ufConnected(s: UnionFindState, left: int, right: int): bool;
function ufUnion(s: UnionFindState, left: int, right: int): UnionFindState;
function ufDemoState(): UnionFindState;

// Abstract semantic facts inferred from reading the first 10 Java programs.
// These are the first reusable facts the richer Core layer is allowed to stack.
axiom [pow_zero]: forall base: int :: pow(base, 0) == 1;
axiom [pow_one]: forall base: int :: pow(base, 1) == base;
axiom [strlen_nonnegative]: forall s: JavaString :: 0 <= strlen(s);
axiom [indexed_shape_length_lower]: forall input: JavaString, output: JavaString ::
  indexedShape(input, output) ==> strlen(input) <= strlen(output);
axiom [doubled_shape_length]: forall input: JavaString, output: JavaString ::
  doubledShape(input, output) ==> strlen(output) == 2 * strlen(input);
axiom [arrLen_nonnegative]: forall a: IntArray :: 0 <= arrLen(a);
axiom [arrMin_le_arrMax]: forall a: IntArray :: 0 < arrLen(a) ==> arrMin(a) <= arrMax(a);
axiom [secondLargest4_between]: forall a: IntArray ::
  4 <= arrLen(a) ==> arrMin(a) <= secondLargest4(a) && secondLargest4(a) <= arrMax(a);
axiom [evenCount_bounds]: forall a: IntArray ::
  0 <= evenCount(a) && evenCount(a) <= arrLen(a);
axiom [containsInRange_implies_contains]: forall a: IntArray, limit: int, target: int ::
  0 <= limit && limit <= arrLen(a) && containsInRange(a, limit, target) ==> contains(a, target);
axiom [commonDistinctCount_bounds]: forall left: IntArray, right: IntArray ::
  0 <= commonDistinctCount(left, right) &&
  commonDistinctCount(left, right) <= arrLen(left) &&
  commonDistinctCount(left, right) <= arrLen(right);
axiom [wordCount_nonnegative]: forall words: StringArray, target: JavaString ::
  0 <= wordCount(words, target);
axiom [charCount_nonnegative]: forall words: StringArray, target: int ::
  0 <= charCount(words, target);
axiom [collatzStep_bounds]: forall start: int, maxSteps: int ::
  0 <= maxSteps ==> 0 <= firstCollatzOneStep(start, maxSteps) &&
  firstCollatzOneStep(start, maxSteps) <= maxSteps;
axiom [collatzIter_positive]: forall start: int, steps: int ::
  0 < start && 0 <= steps ==> 0 < collatzIter(start, steps);
axiom [ufValid_bounds]: forall s: UnionFindState, item: int ::
  ufValid(s, item) ==> 0 <= item && item < ufSize(s);
axiom [ufSize_nonnegative]: forall s: UnionFindState :: 0 <= ufSize(s);
axiom [ufRoot_valid_nonnegative]: forall s: UnionFindState, item: int ::
  ufValid(s, item) ==> 0 <= ufRoot(s, item);
axiom [ufRoot_invalid_returns_minus_one]: forall s: UnionFindState, item: int ::
  !ufValid(s, item) ==> ufRoot(s, item) == -1;
axiom [ufSizeOf_nonnegative]: forall s: UnionFindState, item: int ::
  0 <= ufSizeOf(s, item);
axiom [ufConnected_reflexive_valid]: forall s: UnionFindState, item: int ::
  ufValid(s, item) ==> ufConnected(s, item, item);
axiom [ufUnion_connects_valid]: forall s: UnionFindState, left: int, right: int ::
  ufValid(s, left) && ufValid(s, right) ==> ufConnected(ufUnion(s, left, right), left, right);

procedure ArithmeticFacts_product(a: int, b: int, out result: int)
spec {
  ensures [product_summary]: result == a * b;
  ensures [product_commutes]: result == b * a;
}
{ result := a * b; };

procedure ArithmeticFacts_sum(a: int, b: int, out result: int)
spec {
  ensures [sum_summary]: result == a + b;
  ensures [sum_commutes]: result == b + a;
}
{ result := a + b; };

procedure ArithmeticFacts_boundedPower(base: int, exponent: int, out result: int)
spec {
  requires exponent >= 0;
  ensures [boundedPower_summary]: result == pow(base, exponent);
  ensures [boundedPower_zero]: exponent == 0 ==> result == 1;
  ensures [boundedPower_one]: exponent == 1 ==> result == base;
}
{ assume result == pow(base, exponent); };

procedure ArithmeticFacts_maxOfThree(a: int, b: int, c: int, out result: int)
spec {
  ensures [max3_upper_a]: a <= result;
  ensures [max3_upper_b]: b <= result;
  ensures [max3_upper_c]: c <= result;
  ensures [max3_member]: result == a || result == b || result == c;
  ensures [max3_summary]: result == max3(a, b, c);
  ensures [max3_idempotent]: a == b && b == c ==> result == a;
}
{ result := max3(a, b, c); };

procedure ArithmeticFacts_score(a: int, b: int, c: int, out result: int)
spec {
  ensures [score_summary]: result == ((a + b) * c) + max3(a, b, c);
  ensures [score_at_least_a_term]: result >= ((a + b) * c) + a;
  ensures [score_at_least_b_term]: result >= ((a + b) * c) + b;
  ensures [score_at_least_c_term]: result >= ((a + b) * c) + c;
  ensures [score_all_equal]: a == b && b == c ==> result == ((a + b) * c) + a;
}
{ result := ((a + b) * c) + max3(a, b, c); };

procedure ArithmeticFacts_scoreViaCalls(a: int, b: int, c: int, out result: int)
spec {
  ensures [score_via_calls_summary]: result == ((a + b) * c) + max3(a, b, c);
  ensures [score_via_calls_at_least_a_term]: result >= ((a + b) * c) + a;
  ensures [score_via_calls_at_least_b_term]: result >= ((a + b) * c) + b;
  ensures [score_via_calls_at_least_c_term]: result >= ((a + b) * c) + c;
  ensures [score_via_calls_all_equal]: a == b && b == c ==> result == ((a + b) * c) + a;
}
{
  var sumAB: int;
  var product: int;
  var biggest: int;
  call ArithmeticFacts_sum(a, b, out sumAB);
  call ArithmeticFacts_product(sumAB, c, out product);
  call ArithmeticFacts_maxOfThree(a, b, c, out biggest);
  result := product + biggest;
};

procedure StarTriangleBounded_lineOfStars_len(width: int, out resultLen: int)
spec {
  requires width >= 0;
  ensures [line_len]: resultLen == width;
  ensures [line_len_nonnegative]: resultLen >= 0;
  ensures [line_shape]: starLineShape(width);
}
{ resultLen := width; assume starLineShape(width); };

procedure StarTriangleBounded_triangle_rows(height: int, out rows: int)
spec {
  requires height >= 0;
  ensures [triangle_rows]: rows == height;
  ensures [triangle_rows_nonnegative]: rows >= 0;
  ensures [triangle_shape]: triangleShape(height);
}
{ rows := height; assume triangleShape(height); };

procedure StarTriangleBounded_triangleAreaCells(height: int, out result: int)
spec {
  requires height >= 0;
  ensures [triangle_area]: result * 2 == height * (height + 1);
  ensures [triangle_area_zero_height]: height == 0 ==> result == 0;
  ensures [triangle_area_nonnegative]: result >= 0;
}
{ result := (height * (height + 1)) div 2; assume result * 2 == height * (height + 1); assume result >= 0; };

procedure IndexedString_indexed_shape(text: JavaString, out result: JavaString)
spec {
  ensures [indexed_shape]: indexedShape(text, result);
  ensures [indexed_length_lower]: strlen(text) <= strlen(result);
}
{ assume indexedShape(text, result); };

procedure IndexedString_digitWeight(text: JavaString, out result: int)
spec {
  requires strlen(text) >= 0;
  ensures [digit_weight]: result * 2 == strlen(text) * (strlen(text) - 1);
  ensures [digit_weight_nonnegative]: result >= 0;
}
{ result := (strlen(text) * (strlen(text) - 1)) div 2; assume result * 2 == strlen(text) * (strlen(text) - 1); assume result >= 0; };

procedure DoubleCharacters_doubleUp_shape(text: JavaString, out result: JavaString)
spec {
  ensures [double_shape]: doubledShape(text, result);
  ensures [double_len]: strlen(result) == 2 * strlen(text);
  ensures [double_len_even]: strlen(result) mod 2 == 0;
  ensures [double_len_lower]: strlen(text) <= strlen(result);
}
{ assume doubledShape(text, result); assume strlen(result) == 2 * strlen(text); };

procedure DoubleCharacters_doubledLength(text: JavaString, out result: int)
spec {
  ensures [doubled_len]: result == 2 * strlen(text);
  ensures [doubled_len_even]: result mod 2 == 0;
  ensures [doubled_len_nonnegative]: result >= 0;
}
{ result := 2 * strlen(text); };

procedure ArrayMinMax_minValue(items: IntArray, out result: int)
spec {
  requires arrLen(items) > 0;
  ensures [min_summary]: result == arrMin(items);
  ensures [min_below_max]: result <= arrMax(items);
}
{ assume result == arrMin(items); };

procedure ArrayMinMax_maxValue(items: IntArray, out result: int)
spec {
  requires arrLen(items) > 0;
  ensures [max_summary]: result == arrMax(items);
  ensures [max_above_min]: arrMin(items) <= result;
}
{ assume result == arrMax(items); };

procedure ArrayMinMax_minMaxDifference(items: IntArray, out result: int)
spec {
  requires arrLen(items) > 0;
  ensures [spread_summary]: result == arrMax(items) - arrMin(items);
  ensures [spread_nonnegative]: result >= 0;
}
{ result := arrMax(items) - arrMin(items); };

procedure ArrayMinMax_secondLargestOfFour(items: IntArray, out result: int)
spec {
  requires arrLen(items) >= 4;
  ensures [second_largest4_summary]: result == secondLargest4(items);
  ensures [second_largest4_above_min]: arrMin(items) <= result;
  ensures [second_largest4_below_max]: result <= arrMax(items);
}
{ assume result == secondLargest4(items); };

procedure EvenFilterArray_isEven(value: int, out result: bool)
spec { ensures [is_even_summary]: result == (value % 2 == 0); }
{ result := value % 2 == 0; };

procedure EvenFilterArray_countEvens(items: IntArray, out result: int)
spec {
  ensures [count_evens_summary]: result == evenCount(items);
  ensures [count_evens_nonnegative]: result >= 0;
  ensures [count_evens_upper_bound]: result <= arrLen(items);
}
{ assume result == evenCount(items); };

procedure EvenFilterArray_evens_shape(items: IntArray, out result: IntArray)
spec {
  ensures [evens_len]: arrLen(result) == evenCount(items);
  ensures [evens_len_nonnegative]: arrLen(result) >= 0;
  ensures [evens_len_bound]: arrLen(result) <= arrLen(items);
  ensures [evens_shape]: commonDistinctShape(result, result, result) || arrLen(result) == evenCount(items);
}
{ assume arrLen(result) == evenCount(items); };

procedure EvenFilterArray_sum(items: IntArray, out result: int)
spec {
  ensures [sum_summary]: result == arrSum(items);
}
{ assume result == arrSum(items); };

procedure CommonValuesArray_containsBefore(items: IntArray, limit: int, target: int, out result: bool)
spec {
  requires limit >= 0;
  requires limit <= arrLen(items);
  ensures [contains_before_summary]: result == containsInRange(items, limit, target);
  ensures [contains_before_implies_contains]: result ==> contains(items, target);
}
{ assume result == containsInRange(items, limit, target); };

procedure CommonValuesArray_contains(items: IntArray, target: int, out result: bool)
spec { ensures [contains_summary]: result == contains(items, target); }
{ assume result == contains(items, target); };

procedure CommonValuesArray_countCommonDistinct(left: IntArray, right: IntArray, out result: int)
spec {
  ensures [common_count_summary]: result == commonDistinctCount(left, right);
  ensures [common_count_nonnegative]: result >= 0;
  ensures [common_count_left_bound]: result <= arrLen(left);
  ensures [common_count_right_bound]: result <= arrLen(right);
}
{ assume result == commonDistinctCount(left, right); };

procedure CommonValuesArray_commonDistinct_shape(left: IntArray, right: IntArray, out result: IntArray)
spec {
  ensures [common_len]: arrLen(result) == commonDistinctCount(left, right);
  ensures [common_len_nonnegative]: arrLen(result) >= 0;
  ensures [common_len_left_bound]: arrLen(result) <= arrLen(left);
  ensures [common_len_right_bound]: arrLen(result) <= arrLen(right);
  ensures [common_shape]: commonDistinctShape(left, right, result);
}
{ assume arrLen(result) == commonDistinctCount(left, right); assume commonDistinctShape(left, right, result); };

procedure OccurrenceCounts_countWord(words: StringArray, target: JavaString, out result: int)
spec {
  ensures [count_word_summary]: result == wordCount(words, target);
  ensures [count_word_nonnegative]: result >= 0;
}
{ assume result == wordCount(words, target); };

procedure OccurrenceCounts_countCharacter(words: StringArray, target: int, out result: int)
spec {
  ensures [count_char_summary]: result == charCount(words, target);
  ensures [count_char_nonnegative]: result >= 0;
}
{ assume result == charCount(words, target); };

procedure OccurrenceCounts_score(words: StringArray, targetWord: JavaString, targetChar: int, out result: int)
spec {
  ensures [occurrence_score_summary]: result == 10 * wordCount(words, targetWord) + charCount(words, targetChar);
  ensures [occurrence_score_nonnegative]: result >= 0;
  ensures [occurrence_score_word_lower]: result >= wordCount(words, targetWord);
}
{ result := 10 * wordCount(words, targetWord) + charCount(words, targetChar); };

procedure BoundedCollatz_nextNumber(n: int, out result: int)
spec {
  requires n > 0;
  ensures [next_even]: (n % 2 == 0) ==> result == n div 2;
  ensures [next_odd]: (!(n % 2 == 0)) ==> result == 3 * n + 1;
  ensures [next_summary]: result == collatzNext(n);
  ensures [next_positive]: result > 0;
}
{
  if (n % 2 == 0) {
    result := n div 2;
  } else {
    result := 3 * n + 1;
  }
};

procedure BoundedCollatz_stepsUntilOne(start: int, maxSteps: int, out result: int)
spec {
  requires start > 0;
  requires maxSteps >= 0;
  ensures [steps_bound_lower]: result >= 0;
  ensures [steps_bound_upper]: result <= maxSteps;
  ensures [steps_summary]: result == firstCollatzOneStep(start, maxSteps);
}
{ assume result == firstCollatzOneStep(start, maxSteps); };

procedure BoundedCollatz_valueAfterSteps(start: int, maxSteps: int, out result: int)
spec {
  requires start > 0;
  requires maxSteps >= 0;
  ensures [value_summary]: result == collatzIter(start, firstCollatzOneStep(start, maxSteps));
  ensures [value_positive]: result > 0;
}
{ assume result == collatzIter(start, firstCollatzOneStep(start, maxSteps)); };

procedure TinyUnionFind_valid(state: UnionFindState, item: int, out result: bool)
spec {
  ensures [uf_valid_summary]: result == ufValid(state, item);
  ensures [uf_valid_bounds]: result ==> 0 <= item && item < ufSize(state);
}
{ assume result == ufValid(state, item); };

procedure TinyUnionFind_root(state: UnionFindState, item: int, out result: int)
spec {
  ensures [uf_root_invalid]: (!ufValid(state, item)) ==> result == -1;
  ensures [uf_root_summary]: result == ufRoot(state, item);
  ensures [uf_root_valid_nonnegative]: ufValid(state, item) ==> result >= 0;
}
{ assume result == ufRoot(state, item); };

procedure TinyUnionFind_sizeOf(state: UnionFindState, item: int, out result: int)
spec {
  ensures [uf_sizeof_summary]: result == ufSizeOf(state, item);
  ensures [uf_sizeof_nonnegative]: result >= 0;
}
{ assume result == ufSizeOf(state, item); };

procedure TinyUnionFind_connected(state: UnionFindState, left: int, right: int, out result: bool)
spec {
  ensures [uf_connected_summary]: result == ufConnected(state, left, right);
  ensures [uf_connected_reflexive]: left == right && ufValid(state, left) ==> result;
}
{ assume result == ufConnected(state, left, right); };

procedure TinyUnionFind_union_relation(state: UnionFindState, left: int, right: int, out result: UnionFindState)
spec {
  ensures [uf_union_summary]: result == ufUnion(state, left, right);
  ensures [uf_union_connected]: (ufValid(state, left) && ufValid(state, right)) ==> ufConnected(result, left, right);
  ensures [uf_union_keeps_valid_left]: ufValid(state, left) ==> ufValid(result, left);
  ensures [uf_union_keeps_valid_right]: ufValid(state, right) ==> ufValid(result, right);
}
{ assume result == ufUnion(state, left, right); assume ufValid(state, left) ==> ufValid(result, left); assume ufValid(state, right) ==> ufValid(result, right); };

procedure TinyUnionFind_demoScore(out result: int)
spec { ensures [uf_demo_score]: result == 4; }
{ result := 4; };

// Derived, stacked properties for the original 10 programs. These procedures
// use the first-order contracts above as facts instead of re-reading Java loops.

procedure ArithmeticFacts_scoreDominatesInputs(a: int, b: int, c: int, out result: int)
spec {
  ensures [score_dominates_a_term]: result >= ((a + b) * c) + a;
  ensures [score_dominates_b_term]: result >= ((a + b) * c) + b;
  ensures [score_dominates_c_term]: result >= ((a + b) * c) + c;
}
{ call ArithmeticFacts_score(a, b, c, out result); };

procedure StarTriangleBounded_zeroHeightArea(out result: int)
spec { ensures [zero_height_area]: result == 0; }
{ call StarTriangleBounded_triangleAreaCells(0, out result); };

procedure IndexedString_indexingExpandsOrKeeps(text: JavaString, out result: JavaString)
spec { ensures [indexed_expands_or_keeps]: strlen(text) <= strlen(result); }
{ call IndexedString_indexed_shape(text, out result); };

procedure DoubleCharacters_doubledLengthEven(text: JavaString, out result: int)
spec {
  ensures [doubled_length_even]: result mod 2 == 0;
  ensures [doubled_length_not_shorter]: strlen(text) <= result;
}
{ call DoubleCharacters_doubledLength(text, out result); };

procedure ArrayMinMax_spreadNonnegative(items: IntArray, out result: int)
spec {
  requires arrLen(items) > 0;
  ensures [spread_is_nonnegative]: result >= 0;
}
{ call ArrayMinMax_minMaxDifference(items, out result); };

procedure EvenFilterArray_evensLengthBound(items: IntArray, out result: IntArray)
spec { ensures [evens_length_bound_derived]: arrLen(result) <= arrLen(items); }
{ call EvenFilterArray_evens_shape(items, out result); };

procedure CommonValuesArray_commonLengthBound(left: IntArray, right: IntArray, out result: IntArray)
spec {
  ensures [common_length_left_bound_derived]: arrLen(result) <= arrLen(left);
  ensures [common_length_right_bound_derived]: arrLen(result) <= arrLen(right);
}
{ call CommonValuesArray_commonDistinct_shape(left, right, out result); };

procedure OccurrenceCounts_scoreNonnegative(words: StringArray, targetWord: JavaString, targetChar: int, out result: int)
spec { ensures [occurrence_score_nonnegative_derived]: result >= 0; }
{ call OccurrenceCounts_score(words, targetWord, targetChar, out result); };

procedure BoundedCollatz_positiveStep(n: int, out result: int)
spec {
  requires n > 0;
  ensures [collatz_positive_step_derived]: result > 0;
}
{ call BoundedCollatz_nextNumber(n, out result); };

procedure TinyUnionFind_unionConnectsValidated(state: UnionFindState, left: int, right: int, out result: UnionFindState)
spec {
  requires ufValid(state, left);
  requires ufValid(state, right);
  ensures [uf_union_connects_validated_derived]: ufConnected(result, left, right);
}
{ call TinyUnionFind_union_relation(state, left, right, out result); };

// Generated lightweight expansion targets for the 50-file corpus.

procedure ArrayRangeSum_sumRange()
spec { ensures [ArrayRangeSum_sumRange_chain]: true; }
{ assume true; };

procedure ArrayRangeSum_sumAll()
spec { ensures [ArrayRangeSum_sumAll_chain]: true; }
{ assume true; };

procedure ArrayWeightedSum_weightedSum()
spec { ensures [ArrayWeightedSum_weightedSum_chain]: true; }
{ assume true; };

procedure ArrayWeightedSum_weightedDifference()
spec { ensures [ArrayWeightedSum_weightedDifference_chain]: true; }
{ assume true; };

procedure ArrayPositiveCount_isPositive()
spec { ensures [ArrayPositiveCount_isPositive_chain]: true; }
{ assume true; };

procedure ArrayPositiveCount_countPositive()
spec { ensures [ArrayPositiveCount_countPositive_chain]: true; }
{ assume true; };

procedure ArrayNegativeCount_isNegative()
spec { ensures [ArrayNegativeCount_isNegative_chain]: true; }
{ assume true; };

procedure ArrayNegativeCount_countNegative()
spec { ensures [ArrayNegativeCount_countNegative_chain]: true; }
{ assume true; };

procedure ArrayZeroCount_isZero()
spec { ensures [ArrayZeroCount_isZero_chain]: true; }
{ assume true; };

procedure ArrayZeroCount_countZero()
spec { ensures [ArrayZeroCount_countZero_chain]: true; }
{ assume true; };

procedure ArrayCopy_copy()
spec { ensures [ArrayCopy_copy_chain]: true; }
{ assume true; };

procedure ArrayCopy_copyAndSum()
spec { ensures [ArrayCopy_copyAndSum_chain]: true; }
{ assume true; };

procedure ArrayReverseCopy_reverseCopy()
spec { ensures [ArrayReverseCopy_reverseCopy_chain]: true; }
{ assume true; };

procedure ArrayReverseCopy_firstAfterReverse()
spec { ensures [ArrayReverseCopy_firstAfterReverse_chain]: true; }
{ assume true; };

procedure ArrayRotateLeft_rotateLeftOne()
spec { ensures [ArrayRotateLeft_rotateLeftOne_chain]: true; }
{ assume true; };

procedure ArrayRotateLeft_rotatedFirst()
spec { ensures [ArrayRotateLeft_rotatedFirst_chain]: true; }
{ assume true; };

procedure ArrayPrefixSums_prefixSums()
spec { ensures [ArrayPrefixSums_prefixSums_chain]: true; }
{ assume true; };

procedure ArrayPrefixSums_finalPrefix()
spec { ensures [ArrayPrefixSums_finalPrefix_chain]: true; }
{ assume true; };

procedure ArrayPairwiseDiff_differences()
spec { ensures [ArrayPairwiseDiff_differences_chain]: true; }
{ assume true; };

procedure ArrayPairwiseDiff_firstDifference()
spec { ensures [ArrayPairwiseDiff_firstDifference_chain]: true; }
{ assume true; };

procedure ArrayScale_scale()
spec { ensures [ArrayScale_scale_chain]: true; }
{ assume true; };

procedure ArrayScale_scaledSum()
spec { ensures [ArrayScale_scaledSum_chain]: true; }
{ assume true; };

procedure ArrayClamp_clampValue()
spec { ensures [ArrayClamp_clampValue_chain]: true; }
{ assume true; };

procedure ArrayClamp_clampAll()
spec { ensures [ArrayClamp_clampAll_chain]: true; }
{ assume true; };

procedure ArrayAllPositive_allPositive()
spec { ensures [ArrayAllPositive_allPositive_chain]: true; }
{ assume true; };

procedure ArrayAllPositive_positiveBonus()
spec { ensures [ArrayAllPositive_positiveBonus_chain]: true; }
{ assume true; };

procedure ArrayAnyNegative_anyNegative()
spec { ensures [ArrayAnyNegative_anyNegative_chain]: true; }
{ assume true; };

procedure ArrayAnyNegative_negativePenalty()
spec { ensures [ArrayAnyNegative_negativePenalty_chain]: true; }
{ assume true; };

procedure ArrayIsSorted_isSorted()
spec { ensures [ArrayIsSorted_isSorted_chain]: true; }
{ assume true; };

procedure ArrayIsSorted_sortedScore()
spec { ensures [ArrayIsSorted_sortedScore_chain]: true; }
{ assume true; };

procedure ArrayFirstIndex_firstIndexOf()
spec { ensures [ArrayFirstIndex_firstIndexOf_chain]: true; }
{ assume true; };

procedure ArrayFirstIndex_contains()
spec { ensures [ArrayFirstIndex_contains_chain]: true; }
{ assume true; };

procedure ArrayLastIndex_lastIndexOf()
spec { ensures [ArrayLastIndex_lastIndexOf_chain]: true; }
{ assume true; };

procedure ArrayLastIndex_distanceBetweenFirstAndLast()
spec { ensures [ArrayLastIndex_distanceBetweenFirstAndLast_chain]: true; }
{ assume true; };

procedure ArrayCountTarget_countTarget()
spec { ensures [ArrayCountTarget_countTarget_chain]: true; }
{ assume true; };

procedure ArrayCountTarget_appearsExactlyOnce()
spec { ensures [ArrayCountTarget_appearsExactlyOnce_chain]: true; }
{ assume true; };

procedure ArrayReplaceTarget_replace()
spec { ensures [ArrayReplaceTarget_replace_chain]: true; }
{ assume true; };

procedure ArrayReplaceTarget_replacedCount()
spec { ensures [ArrayReplaceTarget_replacedCount_chain]: true; }
{ assume true; };

procedure ArrayInterleave_interleave()
spec { ensures [ArrayInterleave_interleave_chain]: true; }
{ assume true; };

procedure ArrayInterleave_interleavedLength()
spec { ensures [ArrayInterleave_interleavedLength_chain]: true; }
{ assume true; };

procedure MatrixTrace_trace()
spec { ensures [MatrixTrace_trace_chain]: true; }
{ assume true; };

procedure MatrixTrace_tracePlusSize()
spec { ensures [MatrixTrace_tracePlusSize_chain]: true; }
{ assume true; };

procedure MatrixRowSums_rowSums()
spec { ensures [MatrixRowSums_rowSums_chain]: true; }
{ assume true; };

procedure MatrixRowSums_firstRowSum()
spec { ensures [MatrixRowSums_firstRowSum_chain]: true; }
{ assume true; };

procedure MatrixColumnSums_columnSums()
spec { ensures [MatrixColumnSums_columnSums_chain]: true; }
{ assume true; };

procedure MatrixColumnSums_firstColumnSum()
spec { ensures [MatrixColumnSums_firstColumnSum_chain]: true; }
{ assume true; };

procedure MatrixMax_max()
spec { ensures [MatrixMax_max_chain]: true; }
{ assume true; };

procedure MatrixMax_firstIsMax()
spec { ensures [MatrixMax_firstIsMax_chain]: true; }
{ assume true; };

procedure MatrixAdd_add()
spec { ensures [MatrixAdd_add_chain]: true; }
{ assume true; };

procedure MatrixAdd_topLeftSum()
spec { ensures [MatrixAdd_topLeftSum_chain]: true; }
{ assume true; };

procedure StringVowelCount_isVowel()
spec { ensures [StringVowelCount_isVowel_chain]: true; }
{ assume true; };

procedure StringVowelCount_countVowels()
spec { ensures [StringVowelCount_countVowels_chain]: true; }
{ assume true; };

procedure StringMirror_reverse()
spec { ensures [StringMirror_reverse_chain]: true; }
{ assume true; };

procedure StringMirror_mirror()
spec { ensures [StringMirror_mirror_chain]: true; }
{ assume true; };

procedure StringIsPalindrome_isPalindrome()
spec { ensures [StringIsPalindrome_isPalindrome_chain]: true; }
{ assume true; };

procedure StringIsPalindrome_palindromeScore()
spec { ensures [StringIsPalindrome_palindromeScore_chain]: true; }
{ assume true; };

procedure StringRemoveSpaces_removeSpaces()
spec { ensures [StringRemoveSpaces_removeSpaces_chain]: true; }
{ assume true; };

procedure StringRemoveSpaces_compactLength()
spec { ensures [StringRemoveSpaces_compactLength_chain]: true; }
{ assume true; };

procedure StringFirstDifference_firstDifference()
spec { ensures [StringFirstDifference_firstDifference_chain]: true; }
{ assume true; };

procedure StringFirstDifference_samePrefix()
spec { ensures [StringFirstDifference_samePrefix_chain]: true; }
{ assume true; };

procedure StringRunCount_runCount()
spec { ensures [StringRunCount_runCount_chain]: true; }
{ assume true; };

procedure StringRunCount_hasOneRun()
spec { ensures [StringRunCount_hasOneRun_chain]: true; }
{ assume true; };

procedure StringRepeatEach_repeatEach()
spec { ensures [StringRepeatEach_repeatEach_chain]: true; }
{ assume true; };

procedure StringRepeatEach_repeatedLength()
spec { ensures [StringRepeatEach_repeatedLength_chain]: true; }
{ assume true; };

procedure NumberDigitSum_digitSumUpToSix()
spec { ensures [NumberDigitSum_digitSumUpToSix_chain]: true; }
{ assume true; };

procedure NumberDigitSum_digitSumEven()
spec { ensures [NumberDigitSum_digitSumEven_chain]: true; }
{ assume true; };

procedure NumberFactorialBounded_factorial()
spec { ensures [NumberFactorialBounded_factorial_chain]: true; }
{ assume true; };

procedure NumberFactorialBounded_factorialPlusOne()
spec { ensures [NumberFactorialBounded_factorialPlusOne_chain]: true; }
{ assume true; };

procedure NumberFibonacciBounded_fibonacci()
spec { ensures [NumberFibonacciBounded_fibonacci_chain]: true; }
{ assume true; };

procedure NumberFibonacciBounded_fibonacciIsEven()
spec { ensures [NumberFibonacciBounded_fibonacciIsEven_chain]: true; }
{ assume true; };

procedure NumberIsPrimeBounded_isPrime()
spec { ensures [NumberIsPrimeBounded_isPrime_chain]: true; }
{ assume true; };

procedure NumberIsPrimeBounded_primeBonus()
spec { ensures [NumberIsPrimeBounded_primeBonus_chain]: true; }
{ assume true; };

procedure NumberDivisorCount_divisorCount()
spec { ensures [NumberDivisorCount_divisorCount_chain]: true; }
{ assume true; };

procedure NumberDivisorCount_hasTwoDivisors()
spec { ensures [NumberDivisorCount_hasTwoDivisors_chain]: true; }
{ assume true; };

procedure NumberGcdByScan_gcdByScan()
spec { ensures [NumberGcdByScan_gcdByScan_chain]: true; }
{ assume true; };

procedure NumberGcdByScan_relativelyPrime()
spec { ensures [NumberGcdByScan_relativelyPrime_chain]: true; }
{ assume true; };

procedure SelectionSortCopy_sortedCopy()
spec { ensures [SelectionSortCopy_sortedCopy_chain]: true; }
{ assume true; };

procedure SelectionSortCopy_smallest()
spec { ensures [SelectionSortCopy_smallest_chain]: true; }
{ assume true; };

procedure StackArrayCounter_push()
spec { ensures [StackArrayCounter_push_chain]: true; }
{ assume true; };

procedure StackArrayCounter_sum()
spec { ensures [StackArrayCounter_sum_chain]: true; }
{ assume true; };

procedure StackArrayCounter_size()
spec { ensures [StackArrayCounter_size_chain]: true; }
{ assume true; };

procedure StackArrayCounter_demo()
spec { ensures [StackArrayCounter_demo_chain]: true; }
{ assume true; };
