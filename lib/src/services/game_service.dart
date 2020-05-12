import 'dart:math';

import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/input_condition.dart';
import 'package:perceptron/perceptron.dart';

class GameService {

  static const jsonData = '{"netConfiguration":[7,5,4],"activationFunction":"sigmoid","synapses":[{"layer":0,"origin":0,"destination":0,"weight":36.57775059106368},{"layer":0,"origin":0,"destination":1,"weight":-0.22675941197519986},{"layer":0,"origin":0,"destination":2,"weight":65.57208314840857},{"layer":0,"origin":0,"destination":3,"weight":-0.530096163005392},{"layer":0,"origin":0,"destination":4,"weight":-1.570639295432229},{"layer":0,"origin":1,"destination":0,"weight":19.380158870317267},{"layer":0,"origin":1,"destination":1,"weight":-0.09806618801059051},{"layer":0,"origin":1,"destination":2,"weight":-0.11416015281425355},{"layer":0,"origin":1,"destination":3,"weight":0.7805859102444966},{"layer":0,"origin":1,"destination":4,"weight":52.14904116003327},{"layer":0,"origin":2,"destination":0,"weight":2.3976088251274206},{"layer":0,"origin":2,"destination":1,"weight":-0.11595252674386403},{"layer":0,"origin":2,"destination":2,"weight":-4.803511872240105},{"layer":0,"origin":2,"destination":3,"weight":-0.07067563436595921},{"layer":0,"origin":2,"destination":4,"weight":52.57647107779096},{"layer":0,"origin":3,"destination":0,"weight":-32.09005666216891},{"layer":0,"origin":3,"destination":1,"weight":-2.664145163809537},{"layer":0,"origin":3,"destination":2,"weight":-112.31778080343956},{"layer":0,"origin":3,"destination":3,"weight":-8.681646937354031},{"layer":0,"origin":3,"destination":4,"weight":76.98891143198293},{"layer":0,"origin":4,"destination":0,"weight":-15.943120122705846},{"layer":0,"origin":4,"destination":1,"weight":-3.953558620360999},{"layer":0,"origin":4,"destination":2,"weight":290.98437496973736},{"layer":0,"origin":4,"destination":3,"weight":-10.354141804542868},{"layer":0,"origin":4,"destination":4,"weight":-74.07198906382094},{"layer":0,"origin":5,"destination":0,"weight":212.5183455738607},{"layer":0,"origin":5,"destination":1,"weight":-3.7458247350663036},{"layer":0,"origin":5,"destination":2,"weight":7.403950452344052},{"layer":0,"origin":5,"destination":3,"weight":-2.3590723797695854},{"layer":0,"origin":5,"destination":4,"weight":189.73757449460143},{"layer":0,"origin":6,"destination":0,"weight":-50.09795489767409},{"layer":0,"origin":6,"destination":1,"weight":-0.7303434482495603},{"layer":0,"origin":6,"destination":2,"weight":-7.4689438002345545},{"layer":0,"origin":6,"destination":3,"weight":-0.4307691847298278},{"layer":0,"origin":6,"destination":4,"weight":-3.6784756334968303},{"layer":0,"origin":7,"destination":0,"weight":-24.71202902941337},{"layer":0,"origin":7,"destination":1,"weight":-0.0465705796712732},{"layer":0,"origin":7,"destination":2,"weight":0.03279524141721126},{"layer":0,"origin":7,"destination":3,"weight":-0.8622876157344135},{"layer":0,"origin":7,"destination":4,"weight":-4.6193029171632745},{"layer":1,"origin":0,"destination":0,"weight":2.923824320664186},{"layer":1,"origin":0,"destination":1,"weight":3.880846336689249},{"layer":1,"origin":0,"destination":2,"weight":-11.683773092252988},{"layer":1,"origin":0,"destination":3,"weight":9.378444963273264},{"layer":1,"origin":1,"destination":0,"weight":1.1987510407572923},{"layer":1,"origin":1,"destination":1,"weight":0.5451582001337336},{"layer":1,"origin":1,"destination":2,"weight":-1.6936984656744392},{"layer":1,"origin":1,"destination":3,"weight":-2.5867343114255106},{"layer":1,"origin":2,"destination":0,"weight":2.515154433622183},{"layer":1,"origin":2,"destination":1,"weight":-5.6829214618644635},{"layer":1,"origin":2,"destination":2,"weight":4.843402736502334},{"layer":1,"origin":2,"destination":3,"weight":8.122358612898527},{"layer":1,"origin":3,"destination":0,"weight":1.6608651678060329},{"layer":1,"origin":3,"destination":1,"weight":3.735944695391693},{"layer":1,"origin":3,"destination":2,"weight":-4.511449842000675},{"layer":1,"origin":3,"destination":3,"weight":-1.284901420801232},{"layer":1,"origin":4,"destination":0,"weight":3.1560130613479958},{"layer":1,"origin":4,"destination":1,"weight":2.908727224175394},{"layer":1,"origin":4,"destination":2,"weight":-0.3286968279433918},{"layer":1,"origin":4,"destination":3,"weight":-4.582973411649652},{"layer":1,"origin":5,"destination":0,"weight":-12.988779090484648},{"layer":1,"origin":5,"destination":1,"weight":-3.2700140390875747},{"layer":1,"origin":5,"destination":2,"weight":-1.1752224380541945},{"layer":1,"origin":5,"destination":3,"weight":-19.754152470815523}]}';

  final perceptron = Perceptron.fromJson(jsonData);

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
    for (var i=0; i<1000; i++) {
      perceptron.train(data);
    }
    print('network trained');
    print(perceptron.toJson());
  }

  List<double>_convertInputConditionToArray(InputCondition input) {
    return <double>[
      input.currentHeading.value.toDouble(),
      input.foodDistanceByX.toDouble(),
      input.foodDistanceByY.toDouble(),
      input.upObstacle.toDouble(),
      input.downObstacle.toDouble(),
      input.leftObstacle.toDouble(),
      input.rightObstacle.toDouble(),
    ];
  }
}