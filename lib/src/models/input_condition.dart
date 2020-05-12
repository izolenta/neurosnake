import 'package:meta/meta.dart';
import 'package:neurosnake/src/models/direction.dart';

class InputCondition {
  final Direction currentHeading;
  final int leftObstacle;
  final int rightObstacle;
  final int upObstacle;
  final int downObstacle;
  final int foodDistanceByX;
  final int foodDistanceByY;

  InputCondition({
    @required this.currentHeading,
    @required this.leftObstacle,
    @required this.rightObstacle,
    @required this.upObstacle,
    @required this.downObstacle,
    @required this.foodDistanceByX,
    @required this.foodDistanceByY
  });
}