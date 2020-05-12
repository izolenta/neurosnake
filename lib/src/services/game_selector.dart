import 'package:built_value/built_value.dart';
import 'package:neurosnake/src/models/game_phase.dart';
import 'package:neurosnake/src/models/input_condition.dart';
import 'package:neurosnake/src/state/game_state.dart';

import '../constants.dart';

class GameSelector {

  @memoized
  int getFoodIndex(GameState state) => state.foodCoords;

  @memoized
  List<int> getSnakeBodyIndexes(GameState state) => state.snakeCoords.toList();

  bool isGameInProgress(GameState state) => state.currentPhase == GamePhase.inProgress;

  InputCondition getInputCondition(GameState state, int newHead) {
    return InputCondition(
      leftObstacle: _getLeftObstacle(newHead, state),
      rightObstacle: _getRightObstacle(newHead, state),
      foodDistanceByX: _getFoodDistanceX(newHead, state),
      foodDistanceByY: _getFoodDistanceY(newHead, state),
      currentHeading: state.currentDirection,
      downObstacle: _getDownObstacle(newHead, state),
      upObstacle: _getUpObstacle(newHead, state),
    );
  }

  int _getDownObstacle(int newHead, GameState state) {
    var dist = 1;
    for (var i = newHead + boardWidth; i < boardWidth * boardHeight; i+=boardWidth) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      dist++;
    }
    return dist;
  }

  int _getUpObstacle(int newHead, GameState state) {
    var dist = 1;
    for (var i = newHead - boardWidth; i >= 0; i-=boardWidth) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      dist++;
    }
    return dist;
  }

  int _getLeftObstacle(int newHead, GameState state) {
    var dist = 1;
    var limit = newHead ~/ boardWidth * boardWidth;
    for (var i = newHead - 1; i >= limit; i--) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      dist++;
    }
    return dist;
  }

  int _getRightObstacle(int newHead, GameState state) {
    var dist = 1;
    var limit = newHead ~/ boardWidth * boardWidth + boardWidth - 1;
    for (var i = newHead + 1; i <= limit; i++) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      dist++;
    }
    return dist;
  }

  int _getFoodDistanceX(int newHead, GameState state) {
    final foodX = state.foodCoords % boardWidth;
    final headX = newHead % boardWidth;
    return headX - foodX;
  }

  int _getFoodDistanceY(int newHead, GameState state) {
    final foodY = state.foodCoords ~/ boardWidth;
    final headY = newHead ~/ boardWidth;
    return headY - foodY;
  }
}
