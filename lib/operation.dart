class Operation {
  int _changedIndex;
  int _opIndex;
  int _operandIndex;

  Operation(this._changedIndex, this._opIndex, this._operandIndex);

  int get changedIndex => _changedIndex;

  int get operandIndex => _operandIndex;

  int get opIndex => _opIndex;
}