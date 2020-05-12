import 'dart:math';

import 'package:neurosnake/src/constants.dart';
import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/input_condition.dart';
import 'package:perceptron/perceptron.dart';

class GameService {

  static const jsonData = '{"netConfiguration":[7,8,4],"activationFunction":"sigmoid","synapses":[{"layer":0,"origin":0,"destination":0,"weight":3.8657161789020766},{"layer":0,"origin":0,"destination":1,"weight":-1.2408002381362786},{"layer":0,"origin":0,"destination":2,"weight":-1.7352065600270299},{"layer":0,"origin":0,"destination":3,"weight":0.6445758452423827},{"layer":0,"origin":0,"destination":4,"weight":-0.19327982805551977},{"layer":0,"origin":0,"destination":5,"weight":2.1697847414772204},{"layer":0,"origin":0,"destination":6,"weight":0.4599684605364335},{"layer":0,"origin":0,"destination":7,"weight":-1.8996515406943355},{"layer":0,"origin":1,"destination":0,"weight":0.09521627123547229},{"layer":0,"origin":1,"destination":1,"weight":0.7357694365632087},{"layer":0,"origin":1,"destination":2,"weight":-0.4959045748578331},{"layer":0,"origin":1,"destination":3,"weight":0.3548100008379763},{"layer":0,"origin":1,"destination":4,"weight":0.31339980521267113},{"layer":0,"origin":1,"destination":5,"weight":-0.6949888000810789},{"layer":0,"origin":1,"destination":6,"weight":-0.7560809861346949},{"layer":0,"origin":1,"destination":7,"weight":0.07811529183734509},{"layer":0,"origin":2,"destination":0,"weight":-0.6380102118372517},{"layer":0,"origin":2,"destination":1,"weight":0.8107294257182559},{"layer":0,"origin":2,"destination":2,"weight":0.22410559469529295},{"layer":0,"origin":2,"destination":3,"weight":-0.2725915068256053},{"layer":0,"origin":2,"destination":4,"weight":-0.2284652687204497},{"layer":0,"origin":2,"destination":5,"weight":0.13858206598087083},{"layer":0,"origin":2,"destination":6,"weight":-0.4181429276737154},{"layer":0,"origin":2,"destination":7,"weight":0.4401387273718203},{"layer":0,"origin":3,"destination":0,"weight":-1.5664891224015558},{"layer":0,"origin":3,"destination":1,"weight":2.939448303354191},{"layer":0,"origin":3,"destination":2,"weight":0.2862436633316867},{"layer":0,"origin":3,"destination":3,"weight":-1.6983969720994563},{"layer":0,"origin":3,"destination":4,"weight":-0.04937848953335438},{"layer":0,"origin":3,"destination":5,"weight":1.828416783147686},{"layer":0,"origin":3,"destination":6,"weight":-1.4323406701986554},{"layer":0,"origin":3,"destination":7,"weight":-0.05087734260034634},{"layer":0,"origin":4,"destination":0,"weight":1.6845202718014285},{"layer":0,"origin":4,"destination":1,"weight":-2.4664853285950152},{"layer":0,"origin":4,"destination":2,"weight":0.7528398736390142},{"layer":0,"origin":4,"destination":3,"weight":-0.8459283976910782},{"layer":0,"origin":4,"destination":4,"weight":-1.1844139884459042},{"layer":0,"origin":4,"destination":5,"weight":0.8729134737842542},{"layer":0,"origin":4,"destination":6,"weight":2.4323049729234993},{"layer":0,"origin":4,"destination":7,"weight":-0.39636612314674796},{"layer":0,"origin":5,"destination":0,"weight":0.05775470351185517},{"layer":0,"origin":5,"destination":1,"weight":0.6569718729247621},{"layer":0,"origin":5,"destination":2,"weight":-1.2048664696806337},{"layer":0,"origin":5,"destination":3,"weight":2.639438576893919},{"layer":0,"origin":5,"destination":4,"weight":2.2719029935670743},{"layer":0,"origin":5,"destination":5,"weight":-1.2771209744610519},{"layer":0,"origin":5,"destination":6,"weight":-2.5207519558331213},{"layer":0,"origin":5,"destination":7,"weight":-1.0540538315275363},{"layer":0,"origin":6,"destination":0,"weight":-1.275811755009363},{"layer":0,"origin":6,"destination":1,"weight":-1.5381236818198654},{"layer":0,"origin":6,"destination":2,"weight":1.5441736663059584},{"layer":0,"origin":6,"destination":3,"weight":-0.7397730601062945},{"layer":0,"origin":6,"destination":4,"weight":-1.154599248628603},{"layer":0,"origin":6,"destination":5,"weight":-1.3852517074764445},{"layer":0,"origin":6,"destination":6,"weight":2.1839302946010615},{"layer":0,"origin":6,"destination":7,"weight":1.482256802605235},{"layer":0,"origin":7,"destination":0,"weight":-0.15733838455031152},{"layer":0,"origin":7,"destination":1,"weight":-0.2270041039579586},{"layer":0,"origin":7,"destination":2,"weight":0.6446559275808825},{"layer":0,"origin":7,"destination":3,"weight":-0.4534432591010074},{"layer":0,"origin":7,"destination":4,"weight":-0.1364849968534724},{"layer":0,"origin":7,"destination":5,"weight":-0.5812572256631512},{"layer":0,"origin":7,"destination":6,"weight":0.8970075924096669},{"layer":0,"origin":7,"destination":7,"weight":0.7884467621215012},{"layer":1,"origin":0,"destination":0,"weight":1.8848831668816035},{"layer":1,"origin":0,"destination":1,"weight":-4.619341934762318},{"layer":1,"origin":0,"destination":2,"weight":-0.3415117956523806},{"layer":1,"origin":0,"destination":3,"weight":2.535774405113117},{"layer":1,"origin":1,"destination":0,"weight":0.8202888344718391},{"layer":1,"origin":1,"destination":1,"weight":2.406798698561937},{"layer":1,"origin":1,"destination":2,"weight":-1.4512252069800662},{"layer":1,"origin":1,"destination":3,"weight":-4.2529399071088285},{"layer":1,"origin":2,"destination":0,"weight":-2.562253873599025},{"layer":1,"origin":2,"destination":1,"weight":0.7573127204887989},{"layer":1,"origin":2,"destination":2,"weight":1.8083365179844597},{"layer":1,"origin":2,"destination":3,"weight":-1.116456182337788},{"layer":1,"origin":3,"destination":0,"weight":-0.010814146594018467},{"layer":1,"origin":3,"destination":1,"weight":-0.17853204804570624},{"layer":1,"origin":3,"destination":2,"weight":-3.0036016487993766},{"layer":1,"origin":3,"destination":3,"weight":1.6989173226507583},{"layer":1,"origin":4,"destination":0,"weight":0.27873019971826374},{"layer":1,"origin":4,"destination":1,"weight":0.5000795469622845},{"layer":1,"origin":4,"destination":2,"weight":-2.6936529942669516},{"layer":1,"origin":4,"destination":3,"weight":-0.14010688888609008},{"layer":1,"origin":5,"destination":0,"weight":2.021315463763049},{"layer":1,"origin":5,"destination":1,"weight":-2.600451355549453},{"layer":1,"origin":5,"destination":2,"weight":0.6551145524536407},{"layer":1,"origin":5,"destination":3,"weight":-1.790117646693132},{"layer":1,"origin":6,"destination":0,"weight":-3.392863240594707},{"layer":1,"origin":6,"destination":1,"weight":-2.0354646769472775},{"layer":1,"origin":6,"destination":2,"weight":3.430598733540872},{"layer":1,"origin":6,"destination":3,"weight":0.5099072006262244},{"layer":1,"origin":7,"destination":0,"weight":-2.898343090739374},{"layer":1,"origin":7,"destination":1,"weight":1.0181209683867216},{"layer":1,"origin":7,"destination":2,"weight":0.7995619780479973},{"layer":1,"origin":7,"destination":3,"weight":-1.3858509116267423},{"layer":1,"origin":8,"destination":0,"weight":-1.1373791200168117},{"layer":1,"origin":8,"destination":1,"weight":0.2773117581349838},{"layer":1,"origin":8,"destination":2,"weight":0.30748517683453463},{"layer":1,"origin":8,"destination":3,"weight":-0.8697167624734949}]}';
  final perceptron = Perceptron.fromJson(jsonData);

  //final perceptron = Perceptron([7, 8, 4]);

  Direction getDirection(InputCondition input) {
    final result = perceptron.process(_convertInputConditionToArray(input));
    print('${_convertInputConditionToArray(input)}, $result');
    final maxValue = result.reduce(max);
    if (maxValue == result[0]) {
      return Direction.left;
    }
    if (maxValue == result[1]) {
      return Direction.up;
    }
    if (maxValue == result[2]) {
      return Direction.right;
    }
    return Direction.down;
  }

  void trainNetwork(List<InputCondition> inputs, List<Direction> outputs) {
    final data = <TrainingData>[];
    for (var i = 0; i< inputs.length; i++) {
      final inputArray = _convertInputConditionToArray(inputs[i]);
      final outputArray = <double>[
        outputs[i] == Direction.left? 1.toDouble() : 0.toDouble(),
        outputs[i] == Direction.up? 1.toDouble() : 0.toDouble(),
        outputs[i] == Direction.right? 1.toDouble() : 0.toDouble(),
        outputs[i] == Direction.down? 1.toDouble() : 0.toDouble(),
      ];
      data.add(TrainingData(inputArray, outputArray));
    }
    print('Got ${data.length} records for training');
//    for (var i=0; i<20; i++) {
      perceptron.train(data);
//    }
    print('network trained');
    print(perceptron.toJson());
  }

  List<double> _convertInputConditionToArray(InputCondition input) {
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
}