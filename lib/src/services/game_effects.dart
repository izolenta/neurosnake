import 'package:neurosnake/src/actions/create_food_action.dart';
import 'package:neurosnake/src/actions/game_over_action.dart';
import 'package:neurosnake/src/actions/tick_action.dart';
import 'package:neurosnake/src/services/game_service.dart';
import 'package:neurosnake/src/state/game_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'game_selector.dart';

class GameEffects {

  final GameSelector _selector;
  final GameService _service;

  GameEffects(this._selector, this._service);

  Epic<GameState> getEffects() {
    return combineEpics([
      TypedEpic<GameState, TickAction>(_onTick),
      TypedEpic<GameState, GameOverAction>(_onGameOver),
    ]);
  }

  Stream<Object> _onTick(Stream<TickAction> actions, EpicStore<GameState> store) =>
      Observable(actions).asyncExpand((action) async* {
        if (_selector.getSnakeBodyIndexes(store.state).contains(_selector.getFoodIndex(store.state))) {
//          print('cfood');
          yield CreateFoodAction();
        }
      });

  Stream<Object> _onGameOver(Stream<GameOverAction> actions, EpicStore<GameState> store) =>
      Observable(actions).asyncExpand((action) async* {
        _service.trainNetwork(store.state.inputConditions.asList(), store.state.outputConditions.asList());
      });
}
