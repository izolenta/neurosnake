import 'dart:math';

import 'package:neurosnake/src/constants.dart';
import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/game_phase.dart';
import 'package:neurosnake/src/services/game_selector.dart';
import 'package:neurosnake/src/state/game_state.dart';
import 'package:neurosnake/src/utils/calc_helper.dart';
import 'package:perceptron/perceptron.dart';

final rand = Random();

const jsonData = '{"netConfiguration":[5,16,4],"activationFunction":"sigmoid","synapses":[{"layer":0,"origin":0,"destination":0,"weight":-1.1498527785780088},{"layer":0,"origin":0,"destination":1,"weight":-0.3462787739173763},{"layer":0,"origin":0,"destination":2,"weight":1.0417233195381177},{"layer":0,"origin":0,"destination":3,"weight":0.07988642971238413},{"layer":0,"origin":0,"destination":4,"weight":-0.29859130424813707},{"layer":0,"origin":0,"destination":5,"weight":-0.9613885147776364},{"layer":0,"origin":0,"destination":6,"weight":-0.25110350149767063},{"layer":0,"origin":0,"destination":7,"weight":-0.42736665357878434},{"layer":0,"origin":0,"destination":8,"weight":-0.5390161692442702},{"layer":0,"origin":0,"destination":9,"weight":-0.2262795087252435},{"layer":0,"origin":0,"destination":10,"weight":2.448446470164927},{"layer":0,"origin":0,"destination":11,"weight":-1.1813090902997645},{"layer":0,"origin":0,"destination":12,"weight":-1.6473613868850805},{"layer":0,"origin":0,"destination":13,"weight":-0.1815238567152803},{"layer":0,"origin":0,"destination":14,"weight":0.024777557430376212},{"layer":0,"origin":0,"destination":15,"weight":-1.0878876431670637},{"layer":0,"origin":1,"destination":0,"weight":6.357066919774489},{"layer":0,"origin":1,"destination":1,"weight":-6.082509883354641},{"layer":0,"origin":1,"destination":2,"weight":2.0997790427785006},{"layer":0,"origin":1,"destination":3,"weight":-2.2675798123425186},{"layer":0,"origin":1,"destination":4,"weight":-2.308622375029318},{"layer":0,"origin":1,"destination":5,"weight":1.0980449476355707},{"layer":0,"origin":1,"destination":6,"weight":2.408070249172884},{"layer":0,"origin":1,"destination":7,"weight":-1.8935693638145035},{"layer":0,"origin":1,"destination":8,"weight":-6.145033184481533},{"layer":0,"origin":1,"destination":9,"weight":2.7341987776884498},{"layer":0,"origin":1,"destination":10,"weight":5.171855363561226},{"layer":0,"origin":1,"destination":11,"weight":-0.9943764991440397},{"layer":0,"origin":1,"destination":12,"weight":4.715494889851053},{"layer":0,"origin":1,"destination":13,"weight":4.747709824627831},{"layer":0,"origin":1,"destination":14,"weight":6.584881138356793},{"layer":0,"origin":1,"destination":15,"weight":10.2409741450886},{"layer":0,"origin":2,"destination":0,"weight":7.600474987853101},{"layer":0,"origin":2,"destination":1,"weight":-5.837935498275874},{"layer":0,"origin":2,"destination":2,"weight":7.81616250359268},{"layer":0,"origin":2,"destination":3,"weight":5.551530566987788},{"layer":0,"origin":2,"destination":4,"weight":5.1805055535277695},{"layer":0,"origin":2,"destination":5,"weight":-5.6338360777082706},{"layer":0,"origin":2,"destination":6,"weight":6.8834109847243194},{"layer":0,"origin":2,"destination":7,"weight":-0.5420658110434424},{"layer":0,"origin":2,"destination":8,"weight":1.5219537402352137},{"layer":0,"origin":2,"destination":9,"weight":-3.804955772076667},{"layer":0,"origin":2,"destination":10,"weight":-5.808195076695923},{"layer":0,"origin":2,"destination":11,"weight":3.383622961924806},{"layer":0,"origin":2,"destination":12,"weight":-5.490161542508463},{"layer":0,"origin":2,"destination":13,"weight":3.875252447751809},{"layer":0,"origin":2,"destination":14,"weight":0.7527378879210876},{"layer":0,"origin":2,"destination":15,"weight":-4.096619522744927},{"layer":0,"origin":3,"destination":0,"weight":-4.818597402698902},{"layer":0,"origin":3,"destination":1,"weight":-7.263075982151752},{"layer":0,"origin":3,"destination":2,"weight":-5.171586031776891},{"layer":0,"origin":3,"destination":3,"weight":-3.364932462607074},{"layer":0,"origin":3,"destination":4,"weight":-3.397836226490657},{"layer":0,"origin":3,"destination":5,"weight":-4.422212889685892},{"layer":0,"origin":3,"destination":6,"weight":2.8589423957223192},{"layer":0,"origin":3,"destination":7,"weight":6.563416296626052},{"layer":0,"origin":3,"destination":8,"weight":9.125029208443799},{"layer":0,"origin":3,"destination":9,"weight":4.049927526327625},{"layer":0,"origin":3,"destination":10,"weight":-5.380253576206887},{"layer":0,"origin":3,"destination":11,"weight":-0.08033901180484318},{"layer":0,"origin":3,"destination":12,"weight":-5.208555095099206},{"layer":0,"origin":3,"destination":13,"weight":10.974134552528872},{"layer":0,"origin":3,"destination":14,"weight":1.1592485256914498},{"layer":0,"origin":3,"destination":15,"weight":-0.2424881355394671},{"layer":0,"origin":4,"destination":0,"weight":5.748413208313833},{"layer":0,"origin":4,"destination":1,"weight":-0.17402639123550181},{"layer":0,"origin":4,"destination":2,"weight":-0.053531210103957616},{"layer":0,"origin":4,"destination":3,"weight":0.5385736948023562},{"layer":0,"origin":4,"destination":4,"weight":-1.604616525622828},{"layer":0,"origin":4,"destination":5,"weight":-1.3896174579041027},{"layer":0,"origin":4,"destination":6,"weight":0.7266786924029185},{"layer":0,"origin":4,"destination":7,"weight":-1.3743771387319565},{"layer":0,"origin":4,"destination":8,"weight":8.035252108455625},{"layer":0,"origin":4,"destination":9,"weight":6.42838543847615},{"layer":0,"origin":4,"destination":10,"weight":-3.5988350547440757},{"layer":0,"origin":4,"destination":11,"weight":-2.0427302385156048},{"layer":0,"origin":4,"destination":12,"weight":-3.406669743752042},{"layer":0,"origin":4,"destination":13,"weight":4.13355395961715},{"layer":0,"origin":4,"destination":14,"weight":-0.17082612510203826},{"layer":0,"origin":4,"destination":15,"weight":8.880755889453592},{"layer":0,"origin":5,"destination":0,"weight":-17.42926656766703},{"layer":0,"origin":5,"destination":1,"weight":-1.7932662778336024},{"layer":0,"origin":5,"destination":2,"weight":-12.448867634279898},{"layer":0,"origin":5,"destination":3,"weight":-7.957128900246562},{"layer":0,"origin":5,"destination":4,"weight":-7.516709221131014},{"layer":0,"origin":5,"destination":5,"weight":-3.681645633982035},{"layer":0,"origin":5,"destination":6,"weight":-10.88326290918868},{"layer":0,"origin":5,"destination":7,"weight":-8.140486853714481},{"layer":0,"origin":5,"destination":8,"weight":-15.883287006425292},{"layer":0,"origin":5,"destination":9,"weight":-12.760856683967729},{"layer":0,"origin":5,"destination":10,"weight":-8.501184075878356},{"layer":0,"origin":5,"destination":11,"weight":-5.68476397567259},{"layer":0,"origin":5,"destination":12,"weight":-5.907448856495767},{"layer":0,"origin":5,"destination":13,"weight":-17.403770552542397},{"layer":0,"origin":5,"destination":14,"weight":-8.788034125244476},{"layer":0,"origin":5,"destination":15,"weight":-15.831679395990138},{"layer":1,"origin":0,"destination":0,"weight":-1.98371294412036},{"layer":1,"origin":0,"destination":1,"weight":-0.9298486765630684},{"layer":1,"origin":0,"destination":2,"weight":5.747122647151511},{"layer":1,"origin":0,"destination":3,"weight":-5.625347852987126},{"layer":1,"origin":1,"destination":0,"weight":-2.43928884202216},{"layer":1,"origin":1,"destination":1,"weight":-3.774704809689473},{"layer":1,"origin":1,"destination":2,"weight":-5.784493249690031},{"layer":1,"origin":1,"destination":3,"weight":-28.554427358488958},{"layer":1,"origin":2,"destination":0,"weight":-0.4546236633372721},{"layer":1,"origin":2,"destination":1,"weight":-13.940816330629229},{"layer":1,"origin":2,"destination":2,"weight":0.6298851822402718},{"layer":1,"origin":2,"destination":3,"weight":-0.6207273632611346},{"layer":1,"origin":3,"destination":0,"weight":-0.8770430207996834},{"layer":1,"origin":3,"destination":1,"weight":-10.649748569904535},{"layer":1,"origin":3,"destination":2,"weight":-0.024223663377324678},{"layer":1,"origin":3,"destination":3,"weight":-19.29310290222601},{"layer":1,"origin":4,"destination":0,"weight":-1.0644698943330213},{"layer":1,"origin":4,"destination":1,"weight":-15.689334102704011},{"layer":1,"origin":4,"destination":2,"weight":-0.01299198489405455},{"layer":1,"origin":4,"destination":3,"weight":-11.838639016931724},{"layer":1,"origin":5,"destination":0,"weight":-0.3689521249218326},{"layer":1,"origin":5,"destination":1,"weight":0.36465136189760666},{"layer":1,"origin":5,"destination":2,"weight":-6.5345179947538785},{"layer":1,"origin":5,"destination":3,"weight":-1.932221663103437},{"layer":1,"origin":6,"destination":0,"weight":1.9244756713253401},{"layer":1,"origin":6,"destination":1,"weight":-19.87279617947176},{"layer":1,"origin":6,"destination":2,"weight":3.2072890799525777},{"layer":1,"origin":6,"destination":3,"weight":1.3733931620012174},{"layer":1,"origin":7,"destination":0,"weight":-0.5811806071680687},{"layer":1,"origin":7,"destination":1,"weight":-2.298733025263926},{"layer":1,"origin":7,"destination":2,"weight":-26.068635213149005},{"layer":1,"origin":7,"destination":3,"weight":-0.3222649724237344},{"layer":1,"origin":8,"destination":0,"weight":0.5843846099121934},{"layer":1,"origin":8,"destination":1,"weight":-1.4556618543869517},{"layer":1,"origin":8,"destination":2,"weight":-4.61798280251407},{"layer":1,"origin":8,"destination":3,"weight":-11.648682754363355},{"layer":1,"origin":9,"destination":0,"weight":5.329857712701879},{"layer":1,"origin":9,"destination":1,"weight":2.5260524412657928},{"layer":1,"origin":9,"destination":2,"weight":-1.4842533415072394},{"layer":1,"origin":9,"destination":3,"weight":-1.3194752404822059},{"layer":1,"origin":10,"destination":0,"weight":-10.185401504595307},{"layer":1,"origin":10,"destination":1,"weight":0.741857235647945},{"layer":1,"origin":10,"destination":2,"weight":-1.4354629728620047},{"layer":1,"origin":10,"destination":3,"weight":-0.23116583220088632},{"layer":1,"origin":11,"destination":0,"weight":-0.00667122702353585},{"layer":1,"origin":11,"destination":1,"weight":-14.105195014975273},{"layer":1,"origin":11,"destination":2,"weight":1.8352678450845268},{"layer":1,"origin":11,"destination":3,"weight":-1.3049576590644418},{"layer":1,"origin":12,"destination":0,"weight":-5.507928641654215},{"layer":1,"origin":12,"destination":1,"weight":1.3620055540208609},{"layer":1,"origin":12,"destination":2,"weight":-1.8762247330880375},{"layer":1,"origin":12,"destination":3,"weight":-0.20113285268880754},{"layer":1,"origin":13,"destination":0,"weight":4.525125635736079},{"layer":1,"origin":13,"destination":1,"weight":1.350801412170375},{"layer":1,"origin":13,"destination":2,"weight":-26.69532315998686},{"layer":1,"origin":13,"destination":3,"weight":3.544033339538257},{"layer":1,"origin":14,"destination":0,"weight":-34.64349063649467},{"layer":1,"origin":14,"destination":1,"weight":2.8275504579272646},{"layer":1,"origin":14,"destination":2,"weight":2.482519383484035},{"layer":1,"origin":14,"destination":3,"weight":3.0087522035113063},{"layer":1,"origin":15,"destination":0,"weight":-7.266866578752606},{"layer":1,"origin":15,"destination":1,"weight":2.2562678317249016},{"layer":1,"origin":15,"destination":2,"weight":-1.5867450840280286},{"layer":1,"origin":15,"destination":3,"weight":-7.953918976684937},{"layer":1,"origin":16,"destination":0,"weight":1.4230741225168484},{"layer":1,"origin":16,"destination":1,"weight":-1.0655911746450182},{"layer":1,"origin":16,"destination":2,"weight":-0.8652806070729293},{"layer":1,"origin":16,"destination":3,"weight":-2.5283034153177346}]}';

void main(List args) {
  final perceptron = Perceptron.fromJson(jsonData, 3);
  final _selector = GameSelector();
  final data = <TrainingData>[];
  for (var i=0; i<300000; i++) {
    final state = createGameState();
    final snake = state.snakeCoords;
    final head = snake.first;
    var newHead;
    final possibleTurns = <Direction, int>{};
    final goodTurns = <Direction, int>{};
    for (var direction in Direction.values) {
      if (direction == Direction.up) {
        newHead = head - boardWidth;
        if (newHead < 0) {
          continue;
        }
      }
      if (direction == Direction.left) {
        newHead = head - 1;
        if (newHead % boardWidth == boardWidth - 1) {
          continue;
        }
      }
      if (direction == Direction.down) {
        newHead = head + boardWidth;
        if (newHead >= boardWidth * boardHeight) {
          continue;
        }
      }
      if (direction == Direction.right) {
        newHead = head + 1;
        if (newHead % boardWidth == 0) {
          continue;
        }
      }
      if (snake.contains(newHead)) {
        continue;
      }
      if (_selector.getFoodAngle(head, state) > _selector.getFoodAngle(newHead, state)) {
        goodTurns[direction] = newHead;
      }
      possibleTurns[direction] = newHead;
    }
    if (goodTurns.isEmpty) {
      if (possibleTurns.isEmpty) {
        continue;
      }
      else {
        goodTurns.addAll(possibleTurns);
      }
    }
    final changedDirection = goodTurns.keys.first;
//    final changedHead = goodTurns[changedDirection];
    final input = _selector.getInputCondition(state, head);
//    print('${convertInputConditionToArray(input)}, ${convertDirectionToOutputArray(changedDirection)}');

    data.add(TrainingData(convertInputConditionToArray(input), convertDirectionToOutputArray(changedDirection)));
  }
  perceptron.train(data);
  print(perceptron.toJson());
}

GameState createGameState() {
  final snake = _createSnakeCoords();
  return GameState((c) =>
  c
    ..isHumanMode = true
    ..currentPhase = GamePhase.notStarted
    ..snakeCoords.replace([])
    ..currentDirection = Direction.up
    ..prevDirection = Direction.up
    ..foodCoords = _createFoodCoords(snake)
    ..inputConditions.replace([])
    ..movesCount = 0
    ..snakeCoords.replace(snake)
    ..outputConditions.replace([]));
}

List<int> _createSnakeCoords() {
  final result = <int>[];
  final x = rand.nextInt(boardWidth);
  final y = rand.nextInt(boardHeight-1) + 1;
  for (var i = boardHeight - y; i < boardHeight - y + 1; i++) {
    result.add(i * boardWidth + x);
  }
  for (var i = 0; i < 1000; i++) {
    result.add(rand.nextInt(boardHeight) * boardHeight + rand.nextInt(boardWidth));
  }
  return result;
}

int _createFoodCoords(List<int> bannedCells) {
  var food;
  do {
    food = rand.nextInt(boardWidth * boardHeight);
  } while (bannedCells.contains(food));
  return food;
}