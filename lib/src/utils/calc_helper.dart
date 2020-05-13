import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/input_condition.dart';

import '../constants.dart';

List<double> convertInputConditionToArray(InputCondition input) {
  return <double>[
    input.currentHeading.value.toDouble()/3,
    (input.foodDistanceByX.toDouble() + boardWidth) / (boardWidth * 2),
    (input.foodDistanceByY.toDouble() + boardHeight) / (boardHeight * 2),
    input.upObstacle.toDouble()/boardHeight,
    input.downObstacle.toDouble()/boardHeight,
    input.leftObstacle.toDouble()/boardWidth,
    input.rightObstacle.toDouble()/boardWidth,
  ];
}

List<double> convertDirectionToOutputArray(Direction output) {
  return <double>[
    output == Direction.left? 1.toDouble() : 0.toDouble(),
    output == Direction.up? 1.toDouble() : 0.toDouble(),
    output == Direction.right? 1.toDouble() : 0.toDouble(),
    output == Direction.down? 1.toDouble() : 0.toDouble(),
  ];
}
