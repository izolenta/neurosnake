import 'dart:math';

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

  bool isHumanGameMode(GameState state) => state.isHumanMode;

  InputCondition getInputCondition(GameState state, int newHead) {
    return InputCondition(
      leftObstacle: _getLeftObstacle(newHead, state),
      rightObstacle: _getRightObstacle(newHead, state),
      upObstacle: _getUpObstacle(newHead, state),
      downObstacle: _getDownObstacle(newHead, state),
      foodAngle: getFoodAngle(newHead, state),
    );
  }

  int _getDownObstacle(int newHead, GameState state) {
    for (var i = newHead + boardWidth; i < boardWidth * boardHeight; i += boardWidth) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      return 0;
    }
    return 1;
  }

  int _getUpObstacle(int newHead, GameState state) {
    for (var i = newHead - boardWidth; i >= 0; i -= boardWidth) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      return 0;
    }
    return 1;
  }

  int _getLeftObstacle(int newHead, GameState state) {
    var limit = newHead ~/ boardWidth * boardWidth;
    for (var i = newHead - 1; i >= limit; i--) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      return 0;
    }
    return 1;
  }

  int _getRightObstacle(int newHead, GameState state) {
    var limit = (newHead ~/ boardWidth) * boardWidth + boardWidth - 1;
    for (var i = newHead + 1; i <= limit; i++) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      return 0;
    }
    return 1;
  }

  double getFoodAngle(int newHead, GameState state) {
    final foodX = state.foodCoords % boardWidth;
    final headX = newHead % boardWidth;
    final distX = headX - foodX;
    final foodY = state.foodCoords ~/ boardHeight;
    final headY = newHead ~/ boardHeight;
    final distY = headY - foodY;
    final dist = sqrt((distX*distX) + (distY*distY));
    final angle = (asin(distX/dist) + pi/2*(1 - state.currentDirection.value)) % pi;
    return angle;
  }
}
