import 'dart:math';

import 'package:built_value/built_value.dart';
import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/direction_state.dart';
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

  InputCondition getInputCondition(GameState state) {
    final head = state.snakeCoords.first;
    return InputCondition(
      leftObstacle: _getLeftObstacle(head, state),
      rightObstacle: _getRightObstacle(head, state),
      upObstacle: _getUpObstacle(head, state),
      downObstacle: _getDownObstacle(head, state),
      foodDirection: getFoodDirection(state),
    );
  }

  double _getDownObstacle(int newHead, GameState state) {
    var dist = 1;
    for (var i = newHead + boardWidth; i < boardWidth * boardHeight; i += boardWidth) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      dist++;
    }
    return _getDistanceValue(dist);
  }

  double _getUpObstacle(int newHead, GameState state) {
    var dist = 1;
    for (var i = newHead - boardWidth; i >= 0; i -= boardWidth) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      dist++;
    }
    return _getDistanceValue(dist);
  }

  double _getLeftObstacle(int newHead, GameState state) {
    var dist = 1;
    var limit = newHead ~/ boardWidth * boardWidth;
    for (var i = newHead - 1; i >= limit; i--) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      dist++;
    }
    return _getDistanceValue(dist);
  }

  double _getRightObstacle(int newHead, GameState state) {
    var dist = 1;
    var limit = (newHead ~/ boardWidth) * boardWidth + boardWidth - 1;
    for (var i = newHead + 1; i <= limit; i++) {
      if (getSnakeBodyIndexes(state).contains(i)) {
        break;
      }
      dist++;
    }
    return _getDistanceValue(dist);
  }

  Point<double> getFoodQuadrant(int newHead, GameState state) {
    final foodX = state.foodCoords % boardWidth;
    final headX = newHead % boardWidth;
    final distX = foodX - headX;
    final foodY = state.foodCoords ~/ boardWidth;
    final headY = newHead ~/ boardWidth;
    final distY = foodY - headY;
    final dist = sqrt((distX*distX) + (distY*distY));
    if (dist == 0) {
      return Point(0, 0);
    }
    var quadrant;
    if (distX >= 0) {
      quadrant = distY >= 0? 2 : 1;
    }
    else {
      quadrant = distY >= 0? 3 : 0;
    }

    quadrant = quadrant - state.currentDirection.value;
    if (quadrant < 0) {
      quadrant += 4;
    }
    return Point(quadrant.toDouble(), dist);
  }

  double _getDistanceValue(int dist) {
    if (dist == 1) {
      return 1;
    }
    return 0;
  }

  Point getCoords(int index) => Point(index % boardWidth, index ~/ boardWidth);

  DirectionState getFoodDirection(GameState state) {
    final foodX = state.foodCoords % boardWidth;
    final headX = state.snakeCoords.first % boardWidth;
    final distX = foodX - headX;
    final foodY = state.foodCoords ~/ boardWidth;
    final headY = state.snakeCoords.first ~/ boardWidth;
    final distY = foodY - headY;
    return DirectionState(left: max(-distX.sign, 0), right: max(distX.sign, 0), up: max(-distY.sign, 0), down: max(distY.sign, 0));
//    if (state.currentDirection == Direction.up) {
//      return DirectionState(left: max(-distX.sign, 0), right: max(distX.sign, 0), up: max(-distY.sign, 0), down: max(distY.sign, 0));
//    }
//    if (state.currentDirection == Direction.down) {
//      return DirectionState(left: max(distX.sign, 0), right: max(-distX.sign, 0), up: max(distY.sign, 0), down: max(-distY.sign, 0));
//    }
//    if (state.currentDirection == Direction.right) {
//      return DirectionState(left: max(-distY.sign, 0), right: max(distY.sign, 0), up: max(distX.sign, 0), down: max(-distX.sign, 0));
//    }
////    if (state.currentDirection == Direction.left) {
//      return DirectionState(left: max(distY.sign, 0), right: max(-distY.sign, 0), up: max(-distX.sign, 0), down: max(distX.sign, 0));
////    }
  }
}
