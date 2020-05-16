class PossibleTurn {
  static const PossibleTurn left = PossibleTurn._internal(-1);
  static const PossibleTurn right = PossibleTurn._internal(1);
  static const PossibleTurn noTurn = PossibleTurn._internal(0);

  static const Iterable<PossibleTurn> values = [
    left, right, noTurn
  ];

  final int _value;

  const PossibleTurn._internal(this._value);

  int get value => _value;

  @override
  String toString() => _value.toString();

  String toJson() => _value.toString();
}