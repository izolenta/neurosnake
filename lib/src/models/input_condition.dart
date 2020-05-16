import 'package:meta/meta.dart';

class InputCondition {
  final int leftObstacle;
  final int rightObstacle;
  final int downObstacle;
  final int upObstacle;
  final double foodAngle;

  InputCondition({
    @required this.leftObstacle,
    @required this.rightObstacle,
    @required this.downObstacle,
    @required this.upObstacle,
    @required this.foodAngle,
  });
}