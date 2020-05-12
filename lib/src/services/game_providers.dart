import 'package:angular/angular.dart';
import 'package:redux/redux.dart';

import 'game_dispatcher.dart';
import 'game_effects.dart';
import 'game_reducer.dart';
import 'game_selector.dart';
import 'game_service.dart';
import 'game_state_factory.dart';
import 'game_store_factory.dart';

abstract class GameProviders {
  static const List<Object> providers = [
    ClassProvider<GameDispatcher>(GameDispatcher),
    ClassProvider<GameStateFactory>(GameStateFactory),
    FactoryProvider<Store>(Store, createGameStore),
    ClassProvider<GameReducer>(GameReducer),
    ClassProvider<GameEffects>(GameEffects),
    ClassProvider<GameSelector>(GameSelector),
    ClassProvider<GameService>(GameService),
  ];
}