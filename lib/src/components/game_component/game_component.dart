import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:neurosnake/src/actions/change_direction_action.dart';
import 'package:neurosnake/src/actions/game_over_action.dart';
import 'package:neurosnake/src/actions/start_game_action.dart';
import 'package:neurosnake/src/actions/tick_action.dart';
import 'package:neurosnake/src/components/game_component/board_component/board_component.dart';
import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/input_condition.dart';
import 'package:neurosnake/src/services/game_dispatcher.dart';
import 'package:neurosnake/src/services/game_providers.dart';
import 'package:neurosnake/src/services/game_selector.dart';
import 'package:neurosnake/src/services/game_service.dart';
import 'package:neurosnake/src/state/game_state.dart';
import 'package:redux/redux.dart';

@Component(
  selector: 'snake-game',
  styleUrls: ['game_component.css'],
  templateUrl: 'game_component.html',
  directives: [BoardComponent],
  providers: [GameProviders.providers],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class GameComponent implements OnDestroy {
  final Store<GameState> _store;
  final NgZone _zone;
  final ChangeDetectorRef _detector;
  final GameDispatcher _dispatcher;
  final GameService _service;
  final List<StreamSubscription> _subscriptions = [];
  final GameSelector _selector;

  bool _wasInProgress = false;
  Timer _gameTimer;

  GameState get state => _store.state;

  GameComponent(
      this._store,
      this._zone,
      this._detector,
      this._dispatcher,
      this._selector,
      this._service)
  {
    _init();
  }
  void _init() {
    _zone.runOutsideAngular(() {
      _subscriptions.addAll([
        _store.onChange.listen((_) {
          _zone.run(_detector.markForCheck);
        }),
        _dispatcher.onAction.listen(_store.dispatch),
        document.onKeyDown.listen(_onKeyPress),
      ]);
    });
    _gameTimer = Timer.periodic(Duration(milliseconds: 30), _tick);
  }

  @override
  void ngOnDestroy() {
    _gameTimer.cancel();
    _subscriptions.clear();
    _store?.teardown();
  }

  void _onKeyPress(KeyboardEvent event) {
    if (event.keyCode == KeyCode.SPACE && !_selector.isGameInProgress(state)) {
      _dispatcher.dispatch(StartGameAction());
    }
//    if (_selector.isGameInProgress(state)) {
//      if (event.keyCode == KeyCode.UP) {
//        _dispatcher.dispatch(ChangeDirectionAction(Direction.up));
//      }
//      if (event.keyCode == KeyCode.DOWN) {
//        _dispatcher.dispatch(ChangeDirectionAction(Direction.down));
//      }
//      if (event.keyCode == KeyCode.LEFT) {
//        _dispatcher.dispatch(ChangeDirectionAction(Direction.left));
//      }
//      if (event.keyCode == KeyCode.RIGHT) {
//        _dispatcher.dispatch(ChangeDirectionAction(Direction.right));
//      }
//    }
  }

  void _tick(Timer timer) {
    if (_selector.isGameInProgress(state)) {
      final input = _selector.getInputCondition(state, _selector.getSnakeBodyIndexes(state).first);
      final direction = _service.getDirection(input);
      _dispatcher.dispatch(ChangeDirectionAction(direction));
      Future.delayed(Duration(milliseconds: 10)).then((_) =>_dispatcher.dispatch(TickAction()));
      _wasInProgress = true;
    }
//    else {
//      if (_wasInProgress) {
//        _wasInProgress = false;
//        _dispatcher.dispatch(GameOverAction());
//      }
//    }
  }
}