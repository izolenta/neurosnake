import 'dart:math';

import 'package:neurosnake/src/actions/change_direction_action.dart';
import 'package:neurosnake/src/actions/create_food_action.dart';
import 'package:neurosnake/src/actions/start_game_action.dart';
import 'package:neurosnake/src/actions/tick_action.dart';
import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/game_phase.dart';
import 'package:neurosnake/src/services/game_selector.dart';
import 'package:neurosnake/src/state/game_state.dart';
import 'package:neurosnake/src/utils/calc_helper.dart';
import 'package:redux/redux.dart';

import '../constants.dart';

class GameReducer {

  final rand = Random();
  final GameSelector _selector;

  Reducer<GameState> _reducer;

  GameReducer(this._selector) {
    _reducer = combineReducers([
      TypedReducer<GameState, StartGameAction>(_onStartGame),
      TypedReducer<GameState, TickAction>(_onTick),
      TypedReducer<GameState, ChangeDirectionAction>(_onChangeDirection),
      TypedReducer<GameState, CreateFoodAction>(_onCreateFood),
    ]);
  }

  GameState getState(GameState state, Object action) {
    return _reducer(state, action);
  }

  GameState _onStartGame(GameState state, StartGameAction action) =>
    state.rebuild((s) {
      final snake = _createSnakeCoords();
      s
        ..currentPhase = GamePhase.inProgress
        ..movesCount = 0
        ..currentDirection = Direction.up
        ..snakeCoords.replace(snake)
        ..prevDirection = Direction.up
        ..foodCoords = _createFoodCoords(snake);
    });

  GameState _onChangeDirection(GameState state, ChangeDirectionAction action) =>
      state.rebuild((s) {
        if (isNotOppositeDirection(state.currentDirection, action.newDirection)) {
          s.currentDirection = action.newDirection;
        }
      });

  GameState _onTick(GameState state, TickAction action) =>
      state.rebuild((s) {
        s.movesCount = state.movesCount + 1;
        final snake = _selector.getSnakeBodyIndexes(state);
        final head = snake.first;
        var newHead;
        switch (state.currentDirection) {
          case Direction.up:
            newHead = head - boardWidth;
            if (newHead < 0) {
              s.currentPhase = GamePhase.finished;
            }
            break;
          case Direction.down:
            newHead = head + boardWidth;
            if (newHead >= boardWidth * boardHeight) {
              s.currentPhase = GamePhase.finished;
            }
            break;
          case Direction.left:
            newHead = head - 1;
            if (newHead % boardWidth == boardWidth - 1) {
              s.currentPhase = GamePhase.finished;
            }
            break;
          case Direction.right:
            newHead = head + 1;
            if (newHead % boardWidth == 0) {
              s.currentPhase = GamePhase.finished;
            }
            break;
          default:
            break;
        }
        if (snake.contains(newHead)) {
          s.currentPhase = GamePhase.finished;
        }
        if (s.currentPhase == GamePhase.inProgress) {
          snake.insert(0, newHead);
          final cond = _selector.getInputCondition(state);
          print('${convertInputConditionToArray(cond)} - ${convertDirectionToOutputArray(s.currentDirection)}');
          s.inputConditions.add(cond);
          s.outputConditions.add(s.currentDirection);
          s.prevDirection = s.currentDirection;
        }
        if (_selector.getFoodIndex(state) != newHead) {
          snake.removeLast();
        }
        s.snakeCoords.replace(snake);
      });

  GameState _onCreateFood(GameState state, CreateFoodAction action) =>
    state.rebuild((s) => s.foodCoords = _createFoodCoords(state.snakeCoords.asList()));

  List<int> _createSnakeCoords() {
    final result = <int>[];
    for (var i = boardHeight - 15; i < boardHeight - 10; i++) {
      result.add(i * boardHeight + (boardWidth/4).floor());
    }
    return result;
  }

  int _createFoodCoords(List<int> bannedCells) {
    var food;
    do {
      food = rand.nextInt(boardWidth * boardHeight);
    } while (bannedCells.contains(food));
    return food;
  }

  bool isNotOppositeDirection(Direction current, Direction newDirection) {
    if ((newDirection == Direction.up && current != Direction.down) ||
        (newDirection == Direction.down && current != Direction.up) ||
        (newDirection == Direction.left && current != Direction.right) ||
        (newDirection == Direction.right && current != Direction.left)) {
      return true;
    }
    return false;
  }
}