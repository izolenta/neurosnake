import 'package:meta/meta.dart';
import 'package:neurosnake/src/models/direction_state.dart';

class InputCondition {
  final double leftObstacle;
  final double rightObstacle;
  final double downObstacle;
  final double upObstacle;
  final DirectionState foodDirection;

  InputCondition({
    @required this.leftObstacle,
    @required this.rightObstacle,
    @required this.downObstacle,
    @required this.upObstacle,
    @required this.foodDirection,
  });
}