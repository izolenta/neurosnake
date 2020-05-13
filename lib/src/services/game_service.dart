import 'dart:math';

import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/input_condition.dart';
import 'package:neurosnake/src/utils/calc_helper.dart';
import 'package:perceptron/perceptron.dart';

class GameService {

  static const jsonData = '{"netConfiguration":[7,4,4],"activationFunction":"sigmoid","synapses":[{"layer":0,"origin":0,"destination":0,"weight":3.849982382339523},{"layer":0,"origin":0,"destination":1,"weight":-1.465077056080522},{"layer":0,"origin":0,"destination":2,"weight":-3.422780379813095},{"layer":0,"origin":0,"destination":3,"weight":-0.5016572330497244},{"layer":0,"origin":1,"destination":0,"weight":-4.693709297258793},{"layer":0,"origin":1,"destination":1,"weight":-3.9648952372676614},{"layer":0,"origin":1,"destination":2,"weight":-4.4932541528404135},{"layer":0,"origin":1,"destination":3,"weight":-3.3577987375600586},{"layer":0,"origin":2,"destination":0,"weight":-2.6715491872577104},{"layer":0,"origin":2,"destination":1,"weight":-5.83285096025285},{"layer":0,"origin":2,"destination":2,"weight":8.163498662122363},{"layer":0,"origin":2,"destination":3,"weight":3.1476687634177876},{"layer":0,"origin":3,"destination":0,"weight":-8.478250262760755},{"layer":0,"origin":3,"destination":1,"weight":-8.399071919808598},{"layer":0,"origin":3,"destination":2,"weight":15.638401604723098},{"layer":0,"origin":3,"destination":3,"weight":8.309424158538251},{"layer":0,"origin":4,"destination":0,"weight":8.424737853667187},{"layer":0,"origin":4,"destination":1,"weight":1.2331023619478314},{"layer":0,"origin":4,"destination":2,"weight":-3.705305337110059},{"layer":0,"origin":4,"destination":3,"weight":-17.01758013776539},{"layer":0,"origin":5,"destination":0,"weight":-8.162274389787775},{"layer":0,"origin":5,"destination":1,"weight":2.088089133726652},{"layer":0,"origin":5,"destination":2,"weight":-8.747138389489038},{"layer":0,"origin":5,"destination":3,"weight":4.765272239670787},{"layer":0,"origin":6,"destination":0,"weight":15.914786327231607},{"layer":0,"origin":6,"destination":1,"weight":2.917609392961081},{"layer":0,"origin":6,"destination":2,"weight":5.108418538996282},{"layer":0,"origin":6,"destination":3,"weight":4.437752881790582},{"layer":0,"origin":7,"destination":0,"weight":7.93012847150559},{"layer":0,"origin":7,"destination":1,"weight":-2.80722568834204},{"layer":0,"origin":7,"destination":2,"weight":0.84663407441182},{"layer":0,"origin":7,"destination":3,"weight":-7.507592387134787},{"layer":1,"origin":0,"destination":0,"weight":-10.915155850277571},{"layer":1,"origin":0,"destination":1,"weight":-6.4241068093342575},{"layer":1,"origin":0,"destination":2,"weight":5.030617475771009},{"layer":1,"origin":0,"destination":3,"weight":5.960865812469033},{"layer":1,"origin":1,"destination":0,"weight":-3.9477179458760165},{"layer":1,"origin":1,"destination":1,"weight":-2.388133726897733},{"layer":1,"origin":1,"destination":2,"weight":-1.9205098506558087},{"layer":1,"origin":1,"destination":3,"weight":4.6834781257311136},{"layer":1,"origin":2,"destination":0,"weight":-4.323901510370234},{"layer":1,"origin":2,"destination":1,"weight":0.23805755782928098},{"layer":1,"origin":2,"destination":2,"weight":9.564991616656581},{"layer":1,"origin":2,"destination":3,"weight":-9.324330847251504},{"layer":1,"origin":3,"destination":0,"weight":-6.116329353797127},{"layer":1,"origin":3,"destination":1,"weight":7.975550557332257},{"layer":1,"origin":3,"destination":2,"weight":-2.4672678429755943},{"layer":1,"origin":3,"destination":3,"weight":-6.398396804863336},{"layer":1,"origin":4,"destination":0,"weight":1.524880274972329},{"layer":1,"origin":4,"destination":1,"weight":-7.004569551681022},{"layer":1,"origin":4,"destination":2,"weight":-11.082929593895523},{"layer":1,"origin":4,"destination":3,"weight":-1.1171431520484336}]}';

  final perceptron = Perceptron.fromJson(jsonData);

  //final perceptron = Perceptron([7, 4, 4]);

  Direction getDirection(InputCondition input) {
    final result = perceptron.process(convertInputConditionToArray(input));
    print('${convertInputConditionToArray(input)}, $result');
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
      final inputArray = convertInputConditionToArray(inputs[i]);
      final outputArray = convertDirectionToOutputArray(outputs[i]);
      data.add(TrainingData(inputArray, outputArray));
    }
    print('Got ${data.length} records for training');
//    for (var i=0; i<20; i++) {
      perceptron.train(data);
//    }
    print('network trained');
    print(perceptron.toJson());
  }
}