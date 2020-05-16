import 'dart:math';

import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/input_condition.dart';

import '../constants.dart';

final maxDistance = sqrt(boardWidth*boardWidth + boardHeight*boardHeight);

List<double> convertInputConditionToArray(InputCondition input) {
  return <double>[
    input.foodAngle,
    input.upObstacle.toDouble(),
    input.rightObstacle.toDouble(),
    input.downObstacle.toDouble(),
    input.leftObstacle.toDouble(),
  ];
}

List<double> convertDirectionToOutputArray(Direction output) {
  return <double>[
    output == Direction.up? 1.toDouble() : 0.toDouble(),
    output == Direction.right? 1.toDouble() : 0.toDouble(),
    output == Direction.down? 1.toDouble() : 0.toDouble(),
    output == Direction.left? 1.toDouble() : 0.toDouble(),
  ];
}

