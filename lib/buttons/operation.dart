/// One move on the board: the operator at [opIndex] (0 = +, 1 = -, 2 = ×,
/// 3 = ÷) combined the number at [operandIndex] with the number at
/// [changedIndex], and the result replaced the number at [changedIndex].
class Operation {
  final int changedIndex;
  final int opIndex;
  final int operandIndex;

  /// The value at [changedIndex] before this move, so Undo can restore it
  /// exactly instead of trying to reverse the arithmetic (which fails after
  /// multiplying by 0 and drifts with fractions).
  final double previousValue;

  Operation(
    this.changedIndex,
    this.opIndex,
    this.operandIndex, {
    required this.previousValue,
  });
}

/// Applies operator [opIndex] (0 = +, 1 = -, 2 = ×, 3 = ÷) as `left op right`.
///
/// Returns null when the move isn't allowed: dividing by zero.
double? applyOperation(int opIndex, double left, double right) {
  switch (opIndex) {
    case 0:
      return left + right;
    case 1:
      return left - right;
    case 2:
      return left * right;
    case 3:
      if (right == 0) return null;
      final value = left / right;
      // Snap results like 7.9999999 back to whole numbers.
      if ((value.round() - value).abs() < .01) {
        return value.round().toDouble();
      }
      return value;
  }
  throw ArgumentError.value(opIndex, 'opIndex', 'must be 0-3');
}
