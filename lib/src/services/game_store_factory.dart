import 'package:neurosnake/src/state/game_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'game_effects.dart';
import 'game_reducer.dart';
import 'game_state_factory.dart';

Store<GameState> createGameStore(
    GameStateFactory stateFactory,
    GameReducer reducer,
    GameEffects _effects,) {
  return Store(
      reducer.getState,
      initialState: stateFactory.getInitialState(),
      middleware: [
        EpicMiddleware(_effects.getEffects()),
      ],
      distinct: true
  );
}
