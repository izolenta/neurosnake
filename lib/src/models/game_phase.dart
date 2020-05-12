class GamePhase {
  static const GamePhase notStarted = GamePhase._internal(0);
  static const GamePhase inProgress = GamePhase._internal(1);
  static const GamePhase finished = GamePhase._internal(2);

  static const Iterable<GamePhase> values = [
    notStarted, inProgress, finished,
  ];

  final int _value;

  const GamePhase._internal(this._value);

  int get value => _value;

  @override
  String toString() => _value.toString();

  String toJson() => _value.toString();
}