import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/game_phase.dart';
import 'package:neurosnake/src/state/game_state.dart';

class GameStateFactory {
  GameState getInitialState() =>
      GameState((c) => c
          ..isHumanMode = false
          ..currentPhase = GamePhase.notStarted
          ..snakeCoords.replace([])
          ..currentDirection = Direction.up
          ..prevDirection = Direction.up
          ..foodCoords = -1
          ..inputConditions.replace([])
          ..movesCount = 0
          ..outputConditions.replace([])
      );
}