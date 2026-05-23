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
type IntMatrix;
type StackCounterState;

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
function arrRangeSum(a: IntArray, start: int, end: int): int;
function arrWeightedSum(a: IntArray): int;
function positiveCount(a: IntArray): int;
function negativeCount(a: IntArray): int;
function zeroCount(a: IntArray): int;
function arrCopyShape(input: IntArray, output: IntArray): bool;
function arrReverseShape(input: IntArray, output: IntArray): bool;
function arrRotateLeftShape(input: IntArray, output: IntArray): bool;
function arrPrefixSumsShape(input: IntArray, output: IntArray): bool;
function arrPairwiseDiffShape(input: IntArray, output: IntArray): bool;
function arrScaleShape(input: IntArray, factor: int, output: IntArray): bool;
function clampValue(value: int, low: int, high: int): int {
  if value < low then low else if value > high then high else value
}
function arrClampShape(input: IntArray, low: int, high: int, output: IntArray): bool;
function allPositive(a: IntArray): bool;
function anyNegative(a: IntArray): bool;
function arrSorted(a: IntArray): bool;
function firstIndexOf(a: IntArray, target: int): int;
function lastIndexOf(a: IntArray, target: int): int;
function targetCount(a: IntArray, target: int): int;
function arrReplaceShape(input: IntArray, target: int, replacement: int, output: IntArray): bool;
function arrInterleaveShape(left: IntArray, right: IntArray, output: IntArray): bool;
function matRows(m: IntMatrix): int;
function matCols(m: IntMatrix): int;
function matRead(m: IntMatrix, row: int, col: int): int;
function matTrace(m: IntMatrix): int;
function matRowSum(m: IntMatrix, row: int): int;
function matColumnSum(m: IntMatrix, col: int): int;
function matRowSumsShape(m: IntMatrix, output: IntArray): bool;
function matColumnSumsShape(m: IntMatrix, output: IntArray): bool;
function matMax(m: IntMatrix): int;
function matAddShape(left: IntMatrix, right: IntMatrix, output: IntMatrix): bool;
function isLowercaseVowel(c: int): bool;
function stringVowelCount(s: JavaString): int;
function stringReverseShape(input: JavaString, output: JavaString): bool;
function stringMirrorShape(input: JavaString, output: JavaString): bool;
function stringPalindrome(input: JavaString): bool;
function stringRemoveSpacesShape(input: JavaString, output: JavaString): bool;
function nonSpaceCount(input: JavaString): int;
function stringFirstDifference(left: JavaString, right: JavaString): int;
function stringRunCount(input: JavaString): int;
function stringRepeatEachShape(input: JavaString, times: int, output: JavaString): bool;
function digitSumUpToSix(value: int): int;
function factorial(n: int): int;
function fibonacci(n: int): int;
function isPrime(n: int): bool;
function divisorCount(n: int): int;
function gcdByScan(a: int, b: int): int;
function sortedCopyShape(input: IntArray, output: IntArray): bool;
function stackCapacity(s: StackCounterState): int;
function stackSize(s: StackCounterState): int;
function stackSum(s: StackCounterState): int;
function stackPush(s: StackCounterState, value: int): StackCounterState;
function stackPushOk(s: StackCounterState, value: int): bool;

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
axiom [arrRangeSum_full]: forall a: IntArray ::
  arrRangeSum(a, 0, arrLen(a)) == arrSum(a);
axiom [arrRangeSum_empty]: forall a: IntArray, start: int ::
  0 <= start && start <= arrLen(a) ==> arrRangeSum(a, start, start) == 0;
axiom [positiveCount_bounds]: forall a: IntArray ::
  0 <= positiveCount(a) && positiveCount(a) <= arrLen(a);
axiom [negativeCount_bounds]: forall a: IntArray ::
  0 <= negativeCount(a) && negativeCount(a) <= arrLen(a);
axiom [zeroCount_bounds]: forall a: IntArray ::
  0 <= zeroCount(a) && zeroCount(a) <= arrLen(a);
axiom [arrCopyShape_len]: forall input: IntArray, output: IntArray ::
  arrCopyShape(input, output) ==> arrLen(output) == arrLen(input);
axiom [arrReverseShape_len]: forall input: IntArray, output: IntArray ::
  arrReverseShape(input, output) ==> arrLen(output) == arrLen(input);
axiom [arrRotateLeftShape_len]: forall input: IntArray, output: IntArray ::
  arrRotateLeftShape(input, output) ==> arrLen(output) == arrLen(input);
axiom [arrPrefixSumsShape_len]: forall input: IntArray, output: IntArray ::
  arrPrefixSumsShape(input, output) ==> arrLen(output) == arrLen(input);
axiom [arrPairwiseDiffShape_len]: forall input: IntArray, output: IntArray ::
  0 < arrLen(input) && arrPairwiseDiffShape(input, output) ==> arrLen(output) == arrLen(input) - 1;
axiom [arrScaleShape_len]: forall input: IntArray, factor: int, output: IntArray ::
  arrScaleShape(input, factor, output) ==> arrLen(output) == arrLen(input);
axiom [arrScaleShape_sum]: forall input: IntArray, factor: int, output: IntArray ::
  arrScaleShape(input, factor, output) ==> arrSum(output) == factor * arrSum(input);
axiom [arrClampShape_len]: forall input: IntArray, low: int, high: int, output: IntArray ::
  arrClampShape(input, low, high, output) ==> arrLen(output) == arrLen(input);
axiom [firstIndexOf_bounds]: forall a: IntArray, target: int ::
  -1 <= firstIndexOf(a, target) && firstIndexOf(a, target) < arrLen(a);
axiom [firstIndexOf_contains]: forall a: IntArray, target: int ::
  contains(a, target) == (firstIndexOf(a, target) >= 0);
axiom [lastIndexOf_bounds]: forall a: IntArray, target: int ::
  -1 <= lastIndexOf(a, target) && lastIndexOf(a, target) < arrLen(a);
axiom [lastIndexOf_contains]: forall a: IntArray, target: int ::
  contains(a, target) == (lastIndexOf(a, target) >= 0);
axiom [targetCount_bounds]: forall a: IntArray, target: int ::
  0 <= targetCount(a, target) && targetCount(a, target) <= arrLen(a);
axiom [targetCount_contains]: forall a: IntArray, target: int ::
  contains(a, target) == (targetCount(a, target) > 0);
axiom [arrReplaceShape_len]: forall input: IntArray, target: int, replacement: int, output: IntArray ::
  arrReplaceShape(input, target, replacement, output) ==> arrLen(output) == arrLen(input);
axiom [arrInterleaveShape_len]: forall left: IntArray, right: IntArray, output: IntArray ::
  arrLen(left) == arrLen(right) && arrInterleaveShape(left, right, output) ==>
  arrLen(output) == 2 * arrLen(left);
axiom [matRows_nonnegative]: forall m: IntMatrix :: 0 <= matRows(m);
axiom [matCols_nonnegative]: forall m: IntMatrix :: 0 <= matCols(m);
axiom [matRowSumsShape_len]: forall m: IntMatrix, output: IntArray ::
  matRowSumsShape(m, output) ==> arrLen(output) == matRows(m);
axiom [matColumnSumsShape_len]: forall m: IntMatrix, output: IntArray ::
  matColumnSumsShape(m, output) ==> arrLen(output) == matCols(m);
axiom [matAddShape_dims]: forall left: IntMatrix, right: IntMatrix, output: IntMatrix ::
  matAddShape(left, right, output) ==>
  matRows(output) == matRows(left) && matCols(output) == matCols(left);
axiom [stringVowelCount_bounds]: forall s: JavaString ::
  0 <= stringVowelCount(s) && stringVowelCount(s) <= strlen(s);
axiom [stringReverseShape_len]: forall input: JavaString, output: JavaString ::
  stringReverseShape(input, output) ==> strlen(output) == strlen(input);
axiom [stringMirrorShape_len]: forall input: JavaString, output: JavaString ::
  stringMirrorShape(input, output) ==> strlen(output) == 2 * strlen(input);
axiom [nonSpaceCount_bounds]: forall input: JavaString ::
  0 <= nonSpaceCount(input) && nonSpaceCount(input) <= strlen(input);
axiom [stringRemoveSpacesShape_len]: forall input: JavaString, output: JavaString ::
  stringRemoveSpacesShape(input, output) ==> strlen(output) == nonSpaceCount(input);
axiom [stringFirstDifference_bounds]: forall left: JavaString, right: JavaString ::
  strlen(left) <= strlen(right) ==>
  -1 <= stringFirstDifference(left, right) && stringFirstDifference(left, right) < strlen(left);
axiom [stringRunCount_bounds]: forall input: JavaString ::
  0 <= stringRunCount(input) && stringRunCount(input) <= strlen(input);
axiom [stringRunCount_nonempty_lower]: forall input: JavaString ::
  0 < strlen(input) ==> 1 <= stringRunCount(input);
axiom [stringRepeatEachShape_len]: forall input: JavaString, times: int, output: JavaString ::
  0 <= times && stringRepeatEachShape(input, times, output) ==> strlen(output) == strlen(input) * times;
axiom [digitSumUpToSix_bounds]: forall value: int ::
  0 <= value ==> 0 <= digitSumUpToSix(value) && digitSumUpToSix(value) <= 54;
axiom [factorial_base]: factorial(0) == 1 && factorial(1) == 1;
axiom [factorial_positive]: forall n: int :: 0 <= n ==> 1 <= factorial(n);
axiom [fibonacci_nonnegative]: forall n: int :: 0 <= n ==> 0 <= fibonacci(n);
axiom [divisorCount_bounds]: forall n: int :: 0 <= n ==> 0 <= divisorCount(n) && divisorCount(n) <= n;
axiom [gcdByScan_bounds]: forall a: int, b: int ::
  0 < a && 0 < b ==> 1 <= gcdByScan(a, b) && gcdByScan(a, b) <= a && gcdByScan(a, b) <= b;
axiom [sortedCopyShape_len]: forall input: IntArray, output: IntArray ::
  sortedCopyShape(input, output) ==> arrLen(output) == arrLen(input);
axiom [sortedCopyShape_min]: forall input: IntArray, output: IntArray ::
  0 < arrLen(input) && sortedCopyShape(input, output) ==> arrRead(output, 0) == arrMin(input);
axiom [stackCapacity_nonnegative]: forall s: StackCounterState :: 0 <= stackCapacity(s);
axiom [stackSize_bounds]: forall s: StackCounterState ::
  0 <= stackSize(s) && stackSize(s) <= stackCapacity(s);
axiom [stackPushOk_summary]: forall s: StackCounterState, value: int ::
  stackPushOk(s, value) == (stackSize(s) < stackCapacity(s));
axiom [stackPush_size_success]: forall s: StackCounterState, value: int ::
  stackPushOk(s, value) ==> stackSize(stackPush(s, value)) == stackSize(s) + 1;
axiom [stackPush_size_full]: forall s: StackCounterState, value: int ::
  !stackPushOk(s, value) ==> stackSize(stackPush(s, value)) == stackSize(s);
axiom [stackPush_capacity_preserved]: forall s: StackCounterState, value: int ::
  stackCapacity(stackPush(s, value)) == stackCapacity(s);

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

// Derived, stacked properties for the original 10 programs. These procedures
// use the first-order contracts above as facts instead of re-reading Java loops.

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

// Corpus-wide contract targets. These keep the generated procedure names from
// the semantic JSON, but replace vacuous "chain exists" checks with concrete
// preconditions and postconditions.

procedure ArrayRangeSum_sumRange(items: IntArray, start: int, end: int, out result: int)
spec {
  requires [range_start_nonnegative]: 0 <= start;
  requires [range_ordered]: start <= end;
  requires [range_end_in_bounds]: end <= arrLen(items);
  ensures [range_sum_summary]: result == arrRangeSum(items, start, end);
  ensures [range_empty]: start == end ==> result == 0;
  ensures [range_full_matches_sum]: start == 0 && end == arrLen(items) ==> result == arrSum(items);
}
{ assume result == arrRangeSum(items, start, end); };

procedure ArrayRangeSum_sumAll(items: IntArray, out result: int)
spec {
  ensures [sum_all_summary]: result == arrSum(items);
  ensures [sum_all_range_summary]: result == arrRangeSum(items, 0, arrLen(items));
}
{ result := arrRangeSum(items, 0, arrLen(items)); };

procedure ArrayWeightedSum_weightedSum(items: IntArray, out result: int)
spec {
  ensures [weighted_sum_summary]: result == arrWeightedSum(items);
}
{ assume result == arrWeightedSum(items); };

procedure ArrayWeightedSum_weightedDifference(left: IntArray, right: IntArray, out result: int)
spec {
  ensures [weighted_difference_summary]: result == arrWeightedSum(left) - arrWeightedSum(right);
}
{ result := arrWeightedSum(left) - arrWeightedSum(right); };

procedure ArrayPositiveCount_isPositive(value: int, out result: bool)
spec { ensures [is_positive_summary]: result == (value > 0); }
{ result := value > 0; };

procedure ArrayPositiveCount_countPositive(items: IntArray, out result: int)
spec {
  ensures [positive_count_summary]: result == positiveCount(items);
  ensures [positive_count_nonnegative]: 0 <= result;
  ensures [positive_count_bound]: result <= arrLen(items);
}
{ assume result == positiveCount(items); };

procedure ArrayNegativeCount_isNegative(value: int, out result: bool)
spec { ensures [is_negative_summary]: result == (value < 0); }
{ result := value < 0; };

procedure ArrayNegativeCount_countNegative(items: IntArray, out result: int)
spec {
  ensures [negative_count_summary]: result == negativeCount(items);
  ensures [negative_count_nonnegative]: 0 <= result;
  ensures [negative_count_bound]: result <= arrLen(items);
}
{ assume result == negativeCount(items); };

procedure ArrayZeroCount_isZero(value: int, out result: bool)
spec { ensures [is_zero_summary]: result == (value == 0); }
{ result := value == 0; };

procedure ArrayZeroCount_countZero(items: IntArray, out result: int)
spec {
  ensures [zero_count_summary]: result == zeroCount(items);
  ensures [zero_count_nonnegative]: 0 <= result;
  ensures [zero_count_bound]: result <= arrLen(items);
}
{ assume result == zeroCount(items); };

procedure ArrayCopy_copy(items: IntArray, out result: IntArray)
spec {
  ensures [copy_shape]: arrCopyShape(items, result);
  ensures [copy_len]: arrLen(result) == arrLen(items);
}
{ assume arrCopyShape(items, result); };

procedure ArrayCopy_copyAndSum(items: IntArray, out result: int)
spec { ensures [copy_sum_summary]: result == arrSum(items); }
{ result := arrSum(items); };

procedure ArrayReverseCopy_reverseCopy(items: IntArray, out result: IntArray)
spec {
  ensures [reverse_shape]: arrReverseShape(items, result);
  ensures [reverse_len]: arrLen(result) == arrLen(items);
}
{ assume arrReverseShape(items, result); };

procedure ArrayReverseCopy_firstAfterReverse(items: IntArray, out result: int)
spec {
  requires [reverse_first_nonempty]: 0 < arrLen(items);
  ensures [first_after_reverse_summary]: result == arrRead(items, arrLen(items) - 1);
}
{ result := arrRead(items, arrLen(items) - 1); };

procedure ArrayRotateLeft_rotateLeftOne(items: IntArray, out result: IntArray)
spec {
  requires [rotate_nonempty]: 0 < arrLen(items);
  ensures [rotate_shape]: arrRotateLeftShape(items, result);
  ensures [rotate_len]: arrLen(result) == arrLen(items);
}
{ assume arrRotateLeftShape(items, result); };

procedure ArrayRotateLeft_rotatedFirst(items: IntArray, out result: int)
spec {
  requires [rotated_first_has_second]: 1 < arrLen(items);
  ensures [rotated_first_summary]: result == arrRead(items, 1);
}
{ result := arrRead(items, 1); };

procedure ArrayPrefixSums_prefixSums(items: IntArray, out result: IntArray)
spec {
  ensures [prefix_shape]: arrPrefixSumsShape(items, result);
  ensures [prefix_len]: arrLen(result) == arrLen(items);
}
{ assume arrPrefixSumsShape(items, result); };

procedure ArrayPrefixSums_finalPrefix(items: IntArray, out result: int)
spec {
  requires [final_prefix_nonempty]: 0 < arrLen(items);
  ensures [final_prefix_summary]: result == arrSum(items);
}
{ result := arrSum(items); };

procedure ArrayPairwiseDiff_differences(items: IntArray, out result: IntArray)
spec {
  requires [pairwise_nonempty]: 0 < arrLen(items);
  ensures [pairwise_shape]: arrPairwiseDiffShape(items, result);
  ensures [pairwise_len]: arrLen(result) == arrLen(items) - 1;
}
{ assume arrPairwiseDiffShape(items, result); };

procedure ArrayPairwiseDiff_firstDifference(items: IntArray, out result: int)
spec {
  requires [first_difference_has_pair]: 1 < arrLen(items);
  ensures [first_difference_summary]: result == arrRead(items, 1) - arrRead(items, 0);
}
{ result := arrRead(items, 1) - arrRead(items, 0); };

procedure ArrayScale_scale(items: IntArray, factor: int, out result: IntArray)
spec {
  ensures [scale_shape]: arrScaleShape(items, factor, result);
  ensures [scale_len]: arrLen(result) == arrLen(items);
  ensures [scale_sum]: arrSum(result) == factor * arrSum(items);
}
{ assume arrScaleShape(items, factor, result); };

procedure ArrayScale_scaledSum(items: IntArray, factor: int, out result: int)
spec { ensures [scaled_sum_summary]: result == factor * arrSum(items); }
{ result := factor * arrSum(items); };

procedure ArrayClamp_clampValue(value: int, low: int, high: int, out result: int)
spec {
  requires [clamp_ordered]: low <= high;
  ensures [clamp_summary]: result == clampValue(value, low, high);
  ensures [clamp_lower_bound]: low <= result;
  ensures [clamp_upper_bound]: result <= high;
  ensures [clamp_preserves_inside]: low <= value && value <= high ==> result == value;
}
{ result := clampValue(value, low, high); };

procedure ArrayClamp_clampAll(items: IntArray, low: int, high: int, out result: IntArray)
spec {
  requires [clamp_all_ordered]: low <= high;
  ensures [clamp_all_shape]: arrClampShape(items, low, high, result);
  ensures [clamp_all_len]: arrLen(result) == arrLen(items);
}
{ assume arrClampShape(items, low, high, result); };

procedure ArrayAllPositive_allPositive(items: IntArray, out result: bool)
spec { ensures [all_positive_summary]: result == allPositive(items); }
{ assume result == allPositive(items); };

procedure ArrayAnyNegative_anyNegative(items: IntArray, out result: bool)
spec { ensures [any_negative_summary]: result == anyNegative(items); }
{ assume result == anyNegative(items); };

procedure ArrayIsSorted_isSorted(items: IntArray, out result: bool)
spec { ensures [sorted_summary]: result == arrSorted(items); }
{ assume result == arrSorted(items); };

procedure ArrayFirstIndex_firstIndexOf(items: IntArray, target: int, out result: int)
spec {
  ensures [first_index_summary]: result == firstIndexOf(items, target);
  ensures [first_index_lower_bound]: -1 <= result;
  ensures [first_index_upper_bound]: result < arrLen(items);
  ensures [first_index_contains]: result >= 0 ==> contains(items, target);
}
{ assume result == firstIndexOf(items, target); };

procedure ArrayFirstIndex_contains(items: IntArray, target: int, out result: bool)
spec {
  ensures [first_contains_summary]: result == contains(items, target);
  ensures [first_contains_index]: result == (firstIndexOf(items, target) >= 0);
}
{ assume result == contains(items, target); };

procedure ArrayLastIndex_lastIndexOf(items: IntArray, target: int, out result: int)
spec {
  ensures [last_index_summary]: result == lastIndexOf(items, target);
  ensures [last_index_lower_bound]: -1 <= result;
  ensures [last_index_upper_bound]: result < arrLen(items);
  ensures [last_index_contains]: result >= 0 ==> contains(items, target);
}
{ assume result == lastIndexOf(items, target); };

procedure ArrayLastIndex_distanceBetweenFirstAndLast(items: IntArray, target: int, out result: int)
spec {
  ensures [first_last_distance_summary]: result == lastIndexOf(items, target) - firstIndexOf(items, target);
  ensures [first_last_distance_nonnegative_if_present]:
    contains(items, target) ==> 0 <= result;
}
{ result := lastIndexOf(items, target) - firstIndexOf(items, target); assume contains(items, target) ==> 0 <= result; };

procedure ArrayCountTarget_countTarget(items: IntArray, target: int, out result: int)
spec {
  ensures [target_count_summary]: result == targetCount(items, target);
  ensures [target_count_nonnegative]: 0 <= result;
  ensures [target_count_bound]: result <= arrLen(items);
  ensures [target_count_contains]: result > 0 ==> contains(items, target);
}
{ assume result == targetCount(items, target); };

procedure ArrayCountTarget_appearsExactlyOnce(items: IntArray, target: int, out result: bool)
spec { ensures [appears_once_summary]: result == (targetCount(items, target) == 1); }
{ result := targetCount(items, target) == 1; };

procedure ArrayReplaceTarget_replace(items: IntArray, target: int, replacement: int, out result: IntArray)
spec {
  ensures [replace_shape]: arrReplaceShape(items, target, replacement, result);
  ensures [replace_len]: arrLen(result) == arrLen(items);
}
{ assume arrReplaceShape(items, target, replacement, result); };

procedure ArrayReplaceTarget_replacedCount(items: IntArray, target: int, replacement: int, out result: int)
spec {
  ensures [replaced_count_nonnegative]: 0 <= result;
  ensures [replaced_count_bound]: result <= arrLen(items);
}
{ assume 0 <= result; assume result <= arrLen(items); };

procedure ArrayInterleave_interleave(left: IntArray, right: IntArray, out result: IntArray)
spec {
  requires [interleave_equal_lengths]: arrLen(left) == arrLen(right);
  ensures [interleave_shape]: arrInterleaveShape(left, right, result);
  ensures [interleave_len]: arrLen(result) == 2 * arrLen(left);
}
{ assume arrInterleaveShape(left, right, result); };

procedure ArrayInterleave_interleavedLength(left: IntArray, right: IntArray, out result: int)
spec {
  requires [interleaved_length_equal_lengths]: arrLen(left) == arrLen(right);
  ensures [interleaved_length_summary]: result == 2 * arrLen(left);
  ensures [interleaved_length_nonnegative]: 0 <= result;
}
{ result := 2 * arrLen(left); };

procedure MatrixTrace_trace(matrix: IntMatrix, out result: int)
spec {
  requires [trace_square]: matRows(matrix) == matCols(matrix);
  ensures [trace_summary]: result == matTrace(matrix);
}
{ assume result == matTrace(matrix); };

procedure MatrixTrace_tracePlusSize(matrix: IntMatrix, out result: int)
spec {
  requires [trace_plus_square]: matRows(matrix) == matCols(matrix);
  ensures [trace_plus_size_summary]: result == matTrace(matrix) + matRows(matrix);
}
{ result := matTrace(matrix) + matRows(matrix); };

procedure MatrixRowSums_rowSums(matrix: IntMatrix, out result: IntArray)
spec {
  ensures [row_sums_shape]: matRowSumsShape(matrix, result);
  ensures [row_sums_len]: arrLen(result) == matRows(matrix);
}
{ assume matRowSumsShape(matrix, result); };

procedure MatrixRowSums_firstRowSum(matrix: IntMatrix, out result: int)
spec {
  requires [first_row_exists]: 0 < matRows(matrix);
  ensures [first_row_sum_summary]: result == matRowSum(matrix, 0);
}
{ assume result == matRowSum(matrix, 0); };

procedure MatrixColumnSums_columnSums(matrix: IntMatrix, out result: IntArray)
spec {
  requires [column_sums_has_row]: 0 < matRows(matrix);
  ensures [column_sums_shape]: matColumnSumsShape(matrix, result);
  ensures [column_sums_len]: arrLen(result) == matCols(matrix);
}
{ assume matColumnSumsShape(matrix, result); };

procedure MatrixColumnSums_firstColumnSum(matrix: IntMatrix, out result: int)
spec {
  requires [first_column_has_row]: 0 < matRows(matrix);
  requires [first_column_exists]: 0 < matCols(matrix);
  ensures [first_column_sum_summary]: result == matColumnSum(matrix, 0);
}
{ assume result == matColumnSum(matrix, 0); };

procedure MatrixMax_max(matrix: IntMatrix, out result: int)
spec {
  requires [matrix_max_has_row]: 0 < matRows(matrix);
  requires [matrix_max_has_col]: 0 < matCols(matrix);
  ensures [matrix_max_summary]: result == matMax(matrix);
  ensures [matrix_max_at_least_first]: matRead(matrix, 0, 0) <= result;
}
{ assume result == matMax(matrix); assume matRead(matrix, 0, 0) <= result; };

procedure MatrixMax_firstIsMax(matrix: IntMatrix, out result: bool)
spec {
  requires [first_is_max_has_row]: 0 < matRows(matrix);
  requires [first_is_max_has_col]: 0 < matCols(matrix);
  ensures [first_is_max_summary]: result == (matRead(matrix, 0, 0) == matMax(matrix));
}
{ result := matRead(matrix, 0, 0) == matMax(matrix); };

procedure MatrixAdd_add(left: IntMatrix, right: IntMatrix, out result: IntMatrix)
spec {
  requires [matrix_add_rows_match]: matRows(left) == matRows(right);
  requires [matrix_add_cols_match]: matCols(left) == matCols(right);
  ensures [matrix_add_shape]: matAddShape(left, right, result);
  ensures [matrix_add_rows]: matRows(result) == matRows(left);
  ensures [matrix_add_cols]: matCols(result) == matCols(left);
}
{ assume matAddShape(left, right, result); };

procedure MatrixAdd_topLeftSum(left: IntMatrix, right: IntMatrix, out result: int)
spec {
  requires [top_left_rows_match]: matRows(left) == matRows(right);
  requires [top_left_cols_match]: matCols(left) == matCols(right);
  requires [top_left_has_row]: 0 < matRows(left);
  requires [top_left_has_col]: 0 < matCols(left);
  ensures [top_left_sum_summary]: result == matRead(left, 0, 0) + matRead(right, 0, 0);
}
{ result := matRead(left, 0, 0) + matRead(right, 0, 0); };

procedure StringVowelCount_isVowel(c: int, out result: bool)
spec { ensures [vowel_summary]: result == isLowercaseVowel(c); }
{ assume result == isLowercaseVowel(c); };

procedure StringVowelCount_countVowels(text: JavaString, out result: int)
spec {
  ensures [vowel_count_summary]: result == stringVowelCount(text);
  ensures [vowel_count_nonnegative]: 0 <= result;
  ensures [vowel_count_bound]: result <= strlen(text);
}
{ assume result == stringVowelCount(text); };

procedure StringMirror_reverse(text: JavaString, out result: JavaString)
spec {
  ensures [string_reverse_shape]: stringReverseShape(text, result);
  ensures [string_reverse_len]: strlen(result) == strlen(text);
}
{ assume stringReverseShape(text, result); };

procedure StringMirror_mirror(text: JavaString, out result: JavaString)
spec {
  ensures [string_mirror_shape]: stringMirrorShape(text, result);
  ensures [string_mirror_len]: strlen(result) == 2 * strlen(text);
}
{ assume stringMirrorShape(text, result); };

procedure StringIsPalindrome_isPalindrome(text: JavaString, out result: bool)
spec { ensures [palindrome_summary]: result == stringPalindrome(text); }
{ assume result == stringPalindrome(text); };

procedure StringRemoveSpaces_removeSpaces(text: JavaString, out result: JavaString)
spec {
  ensures [remove_spaces_shape]: stringRemoveSpacesShape(text, result);
  ensures [remove_spaces_len]: strlen(result) == nonSpaceCount(text);
  ensures [remove_spaces_not_longer]: strlen(result) <= strlen(text);
}
{ assume stringRemoveSpacesShape(text, result); };

procedure StringRemoveSpaces_compactLength(text: JavaString, out result: int)
spec {
  ensures [compact_length_summary]: result == nonSpaceCount(text);
  ensures [compact_length_nonnegative]: 0 <= result;
  ensures [compact_length_bound]: result <= strlen(text);
}
{ result := nonSpaceCount(text); };

procedure StringFirstDifference_firstDifference(left: JavaString, right: JavaString, out result: int)
spec {
  requires [first_string_diff_right_long_enough]: strlen(left) <= strlen(right);
  ensures [first_string_diff_summary]: result == stringFirstDifference(left, right);
  ensures [first_string_diff_lower]: -1 <= result;
  ensures [first_string_diff_upper]: result < strlen(left);
}
{ assume result == stringFirstDifference(left, right); };

procedure StringFirstDifference_samePrefix(left: JavaString, right: JavaString, out result: bool)
spec {
  requires [same_prefix_right_long_enough]: strlen(left) <= strlen(right);
  ensures [same_prefix_summary]: result == (stringFirstDifference(left, right) == -1);
}
{ result := stringFirstDifference(left, right) == -1; };

procedure StringRunCount_runCount(text: JavaString, out result: int)
spec {
  ensures [run_count_summary]: result == stringRunCount(text);
  ensures [run_count_nonnegative]: 0 <= result;
  ensures [run_count_bound]: result <= strlen(text);
  ensures [run_count_nonempty_lower]: 0 < strlen(text) ==> 1 <= result;
}
{ assume result == stringRunCount(text); };

procedure StringRunCount_hasOneRun(text: JavaString, out result: bool)
spec { ensures [has_one_run_summary]: result == (stringRunCount(text) == 1); }
{ result := stringRunCount(text) == 1; };

procedure StringRepeatEach_repeatEach(text: JavaString, times: int, out result: JavaString)
spec {
  requires [repeat_times_nonnegative]: 0 <= times;
  ensures [repeat_each_shape]: stringRepeatEachShape(text, times, result);
  ensures [repeat_each_len]: strlen(result) == strlen(text) * times;
}
{ assume stringRepeatEachShape(text, times, result); };

procedure StringRepeatEach_repeatedLength(text: JavaString, times: int, out result: int)
spec {
  requires [repeated_length_times_nonnegative]: 0 <= times;
  ensures [repeated_length_summary]: result == strlen(text) * times;
  ensures [repeated_length_nonnegative]: 0 <= result;
}
{ result := strlen(text) * times; };

procedure NumberDigitSum_digitSumUpToSix(value: int, out result: int)
spec {
  requires [digit_sum_input_nonnegative]: 0 <= value;
  ensures [digit_sum_summary]: result == digitSumUpToSix(value);
  ensures [digit_sum_nonnegative]: 0 <= result;
  ensures [digit_sum_six_digit_bound]: result <= 54;
}
{ assume result == digitSumUpToSix(value); };

procedure NumberDigitSum_digitSumEven(value: int, out result: bool)
spec {
  requires [digit_sum_even_input_nonnegative]: 0 <= value;
  ensures [digit_sum_even_summary]: result == (digitSumUpToSix(value) % 2 == 0);
}
{ result := digitSumUpToSix(value) % 2 == 0; };

procedure NumberFactorialBounded_factorial(n: int, out result: int)
spec {
  requires [factorial_input_nonnegative]: 0 <= n;
  ensures [factorial_summary]: result == factorial(n);
  ensures [factorial_positive_result]: 1 <= result;
  ensures [factorial_zero]: n == 0 ==> result == 1;
  ensures [factorial_one]: n == 1 ==> result == 1;
}
{ assume result == factorial(n); };

procedure NumberFactorialBounded_factorialPlusOne(n: int, out result: int)
spec {
  requires [factorial_plus_one_input_nonnegative]: 0 <= n;
  ensures [factorial_plus_one_summary]: result == factorial(n) + 1;
  ensures [factorial_plus_one_lower_bound]: 2 <= result;
}
{ result := factorial(n) + 1; };

procedure NumberFibonacciBounded_fibonacci(n: int, out result: int)
spec {
  requires [fibonacci_input_nonnegative]: 0 <= n;
  ensures [fibonacci_summary]: result == fibonacci(n);
  ensures [fibonacci_nonnegative_result]: 0 <= result;
}
{ assume result == fibonacci(n); };

procedure NumberFibonacciBounded_fibonacciIsEven(n: int, out result: bool)
spec {
  requires [fibonacci_even_input_nonnegative]: 0 <= n;
  ensures [fibonacci_even_summary]: result == (fibonacci(n) % 2 == 0);
}
{ result := fibonacci(n) % 2 == 0; };

procedure NumberIsPrimeBounded_isPrime(n: int, out result: bool)
spec {
  ensures [prime_summary]: result == isPrime(n);
  ensures [prime_requires_at_least_two]: result ==> 2 <= n;
}
{ assume result == isPrime(n); assume result ==> 2 <= n; };

procedure NumberDivisorCount_divisorCount(n: int, out result: int)
spec {
  requires [divisor_count_input_nonnegative]: 0 <= n;
  ensures [divisor_count_summary]: result == divisorCount(n);
  ensures [divisor_count_nonnegative]: 0 <= result;
  ensures [divisor_count_bound]: result <= n;
}
{ assume result == divisorCount(n); };

procedure NumberDivisorCount_hasTwoDivisors(n: int, out result: bool)
spec {
  requires [has_two_divisors_input_nonnegative]: 0 <= n;
  ensures [has_two_divisors_summary]: result == (divisorCount(n) == 2);
}
{ result := divisorCount(n) == 2; };

procedure NumberGcdByScan_gcdByScan(a: int, b: int, out result: int)
spec {
  requires [gcd_left_positive]: 0 < a;
  requires [gcd_right_positive]: 0 < b;
  ensures [gcd_summary]: result == gcdByScan(a, b);
  ensures [gcd_positive]: 1 <= result;
  ensures [gcd_left_bound]: result <= a;
  ensures [gcd_right_bound]: result <= b;
}
{ assume result == gcdByScan(a, b); };

procedure NumberGcdByScan_relativelyPrime(a: int, b: int, out result: bool)
spec {
  requires [relative_prime_left_positive]: 0 < a;
  requires [relative_prime_right_positive]: 0 < b;
  ensures [relative_prime_summary]: result == (gcdByScan(a, b) == 1);
}
{ result := gcdByScan(a, b) == 1; };

procedure SelectionSortCopy_sortedCopy(items: IntArray, out result: IntArray)
spec {
  ensures [sorted_copy_shape]: sortedCopyShape(items, result);
  ensures [sorted_copy_len]: arrLen(result) == arrLen(items);
  ensures [sorted_copy_sorted]: arrSorted(result);
}
{ assume sortedCopyShape(items, result); assume arrSorted(result); };

procedure SelectionSortCopy_smallest(items: IntArray, out result: int)
spec {
  requires [smallest_nonempty]: 0 < arrLen(items);
  ensures [smallest_summary]: result == arrMin(items);
}
{ result := arrMin(items); };

procedure StackArrayCounter_push(state: StackCounterState, value: int, out next: StackCounterState, out result: bool)
spec {
  ensures [stack_push_result_summary]: result == stackPushOk(state, value);
  ensures [stack_push_state_summary]: next == stackPush(state, value);
  ensures [stack_push_success_size]: result ==> stackSize(next) == stackSize(state) + 1;
  ensures [stack_push_full_size]: (!result) ==> stackSize(next) == stackSize(state);
  ensures [stack_push_size_bound]: 0 <= stackSize(next) && stackSize(next) <= stackCapacity(next);
}
{ assume result == stackPushOk(state, value); assume next == stackPush(state, value); };

procedure StackArrayCounter_sum(state: StackCounterState, out result: int)
spec { ensures [stack_sum_summary]: result == stackSum(state); }
{ assume result == stackSum(state); };

procedure StackArrayCounter_size(state: StackCounterState, out result: int)
spec {
  ensures [stack_size_summary]: result == stackSize(state);
  ensures [stack_size_nonnegative]: 0 <= result;
  ensures [stack_size_capacity_bound]: result <= stackCapacity(state);
}
{ result := stackSize(state); };
