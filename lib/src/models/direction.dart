class Direction {
  static const Direction up = Direction._internal(0);
  static const Direction right = Direction._internal(1);
  static const Direction down = Direction._internal(2);
  static const Direction left = Direction._internal(3);

  static const Iterable<Direction> values = [
    up, right, down, left
  ];

  static Direction parse(int input) {
    if (input == null) {
      return null;
    }

    final parsedValue = values.firstWhere((v) => v._value == input, orElse: () => null);
    return parsedValue;
  }

  final int _value;

  const Direction._internal(this._value);

  int get value => _value;


  @override
  String toString() => _value.toString();

  String toJson() => _value.toString();
}