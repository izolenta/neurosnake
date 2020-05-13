library neurosnake.state.game_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/game_phase.dart';
import 'package:neurosnake/src/models/input_condition.dart';

part 'game_state.g.dart';

abstract class GameState implements Built<GameState, GameStateBuilder> {
  factory GameState([void Function(GameStateBuilder b) updates]) = _$GameState;

  GameState._();

  Direction get currentDirection;

  Direction get prevDirection;

  BuiltList<int> get snakeCoords;

  GamePhase get currentPhase;

  bool get isHumanMode;

  int get foodCoords;

  int get movesCount;

  BuiltList<InputCondition> get inputConditions;

  BuiltList<Direction> get outputConditions;
}