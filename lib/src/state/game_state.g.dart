// GENERATED CODE - DO NOT MODIFY BY HAND

part of neurosnake.state.game_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GameState extends GameState {
  @override
  final Direction currentDirection;
  @override
  final Direction prevDirection;
  @override
  final BuiltList<int> snakeCoords;
  @override
  final GamePhase currentPhase;
  @override
  final bool isHumanMode;
  @override
  final int foodCoords;
  @override
  final int movesCount;
  @override
  final BuiltList<InputCondition> inputConditions;
  @override
  final BuiltList<Direction> outputConditions;

  factory _$GameState([void Function(GameStateBuilder) updates]) =>
      (new GameStateBuilder()..update(updates)).build();

  _$GameState._(
      {this.currentDirection,
      this.prevDirection,
      this.snakeCoords,
      this.currentPhase,
      this.isHumanMode,
      this.foodCoords,
      this.movesCount,
      this.inputConditions,
      this.outputConditions})
      : super._() {
    if (currentDirection == null) {
      throw new BuiltValueNullFieldError('GameState', 'currentDirection');
    }
    if (prevDirection == null) {
      throw new BuiltValueNullFieldError('GameState', 'prevDirection');
    }
    if (snakeCoords == null) {
      throw new BuiltValueNullFieldError('GameState', 'snakeCoords');
    }
    if (currentPhase == null) {
      throw new BuiltValueNullFieldError('GameState', 'currentPhase');
    }
    if (isHumanMode == null) {
      throw new BuiltValueNullFieldError('GameState', 'isHumanMode');
    }
    if (foodCoords == null) {
      throw new BuiltValueNullFieldError('GameState', 'foodCoords');
    }
    if (movesCount == null) {
      throw new BuiltValueNullFieldError('GameState', 'movesCount');
    }
    if (inputConditions == null) {
      throw new BuiltValueNullFieldError('GameState', 'inputConditions');
    }
    if (outputConditions == null) {
      throw new BuiltValueNullFieldError('GameState', 'outputConditions');
    }
  }

  @override
  GameState rebuild(void Function(GameStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GameStateBuilder toBuilder() => new GameStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GameState &&
        currentDirection == other.currentDirection &&
        prevDirection == other.prevDirection &&
        snakeCoords == other.snakeCoords &&
        currentPhase == other.currentPhase &&
        isHumanMode == other.isHumanMode &&
        foodCoords == other.foodCoords &&
        movesCount == other.movesCount &&
        inputConditions == other.inputConditions &&
        outputConditions == other.outputConditions;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, currentDirection.hashCode),
                                    prevDirection.hashCode),
                                snakeCoords.hashCode),
                            currentPhase.hashCode),
                        isHumanMode.hashCode),
                    foodCoords.hashCode),
                movesCount.hashCode),
            inputConditions.hashCode),
        outputConditions.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GameState')
          ..add('currentDirection', currentDirection)
          ..add('prevDirection', prevDirection)
          ..add('snakeCoords', snakeCoords)
          ..add('currentPhase', currentPhase)
          ..add('isHumanMode', isHumanMode)
          ..add('foodCoords', foodCoords)
          ..add('movesCount', movesCount)
          ..add('inputConditions', inputConditions)
          ..add('outputConditions', outputConditions))
        .toString();
  }
}

class GameStateBuilder implements Builder<GameState, GameStateBuilder> {
  _$GameState _$v;

  Direction _currentDirection;
  Direction get currentDirection => _$this._currentDirection;
  set currentDirection(Direction currentDirection) =>
      _$this._currentDirection = currentDirection;

  Direction _prevDirection;
  Direction get prevDirection => _$this._prevDirection;
  set prevDirection(Direction prevDirection) =>
      _$this._prevDirection = prevDirection;

  ListBuilder<int> _snakeCoords;
  ListBuilder<int> get snakeCoords =>
      _$this._snakeCoords ??= new ListBuilder<int>();
  set snakeCoords(ListBuilder<int> snakeCoords) =>
      _$this._snakeCoords = snakeCoords;

  GamePhase _currentPhase;
  GamePhase get currentPhase => _$this._currentPhase;
  set currentPhase(GamePhase currentPhase) =>
      _$this._currentPhase = currentPhase;

  bool _isHumanMode;
  bool get isHumanMode => _$this._isHumanMode;
  set isHumanMode(bool isHumanMode) => _$this._isHumanMode = isHumanMode;

  int _foodCoords;
  int get foodCoords => _$this._foodCoords;
  set foodCoords(int foodCoords) => _$this._foodCoords = foodCoords;

  int _movesCount;
  int get movesCount => _$this._movesCount;
  set movesCount(int movesCount) => _$this._movesCount = movesCount;

  ListBuilder<InputCondition> _inputConditions;
  ListBuilder<InputCondition> get inputConditions =>
      _$this._inputConditions ??= new ListBuilder<InputCondition>();
  set inputConditions(ListBuilder<InputCondition> inputConditions) =>
      _$this._inputConditions = inputConditions;

  ListBuilder<Direction> _outputConditions;
  ListBuilder<Direction> get outputConditions =>
      _$this._outputConditions ??= new ListBuilder<Direction>();
  set outputConditions(ListBuilder<Direction> outputConditions) =>
      _$this._outputConditions = outputConditions;

  GameStateBuilder();

  GameStateBuilder get _$this {
    if (_$v != null) {
      _currentDirection = _$v.currentDirection;
      _prevDirection = _$v.prevDirection;
      _snakeCoords = _$v.snakeCoords?.toBuilder();
      _currentPhase = _$v.currentPhase;
      _isHumanMode = _$v.isHumanMode;
      _foodCoords = _$v.foodCoords;
      _movesCount = _$v.movesCount;
      _inputConditions = _$v.inputConditions?.toBuilder();
      _outputConditions = _$v.outputConditions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GameState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GameState;
  }

  @override
  void update(void Function(GameStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GameState build() {
    _$GameState _$result;
    try {
      _$result = _$v ??
          new _$GameState._(
              currentDirection: currentDirection,
              prevDirection: prevDirection,
              snakeCoords: snakeCoords.build(),
              currentPhase: currentPhase,
              isHumanMode: isHumanMode,
              foodCoords: foodCoords,
              movesCount: movesCount,
              inputConditions: inputConditions.build(),
              outputConditions: outputConditions.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'snakeCoords';
        snakeCoords.build();

        _$failedField = 'inputConditions';
        inputConditions.build();
        _$failedField = 'outputConditions';
        outputConditions.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GameState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
