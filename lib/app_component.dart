import 'package:angular/angular.dart';
import 'package:neurosnake/src/components/game_component/game_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [GameComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class AppComponent {
}
