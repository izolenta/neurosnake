import 'dart:math';

import 'package:neurosnake/src/constants.dart';
import 'package:neurosnake/src/models/direction.dart';
import 'package:neurosnake/src/models/game_phase.dart';
import 'package:neurosnake/src/models/input_condition.dart';
import 'package:neurosnake/src/services/game_selector.dart';
import 'package:neurosnake/src/state/game_state.dart';
import 'package:neurosnake/src/utils/calc_helper.dart';
import 'package:perceptron/perceptron.dart';

final rand = Random();

const jsonData = '{"netConfiguration":[8,20,4],"activationFunction":"sigmoid","synapses":[{"layer":0,"origin":0,"destination":0,"weight":1.0027784338885006},{"layer":0,"origin":0,"destination":1,"weight":4.676758002655921},{"layer":0,"origin":0,"destination":2,"weight":-1.4348067353362657},{"layer":0,"origin":0,"destination":3,"weight":-0.6334296466323889},{"layer":0,"origin":0,"destination":4,"weight":-4.061354000524574},{"layer":0,"origin":0,"destination":5,"weight":-4.051442519879371},{"layer":0,"origin":0,"destination":6,"weight":1.6754105634662968},{"layer":0,"origin":0,"destination":7,"weight":-1.4454804214068966},{"layer":0,"origin":0,"destination":8,"weight":-3.7395915134694473},{"layer":0,"origin":0,"destination":9,"weight":1.4849280121336563},{"layer":0,"origin":0,"destination":10,"weight":-5.781102791986104},{"layer":0,"origin":0,"destination":11,"weight":0.3111686538917391},{"layer":0,"origin":0,"destination":12,"weight":1.9782529656892247},{"layer":0,"origin":0,"destination":13,"weight":2.1488920124025896},{"layer":0,"origin":0,"destination":14,"weight":1.5627234615063301},{"layer":0,"origin":0,"destination":15,"weight":1.7706783822057734},{"layer":0,"origin":0,"destination":16,"weight":-0.8481884982162675},{"layer":0,"origin":0,"destination":17,"weight":1.2163279616470384},{"layer":0,"origin":0,"destination":18,"weight":-5.7534283444076415},{"layer":0,"origin":0,"destination":19,"weight":-4.8624131109281565},{"layer":0,"origin":1,"destination":0,"weight":2.6129793275946853},{"layer":0,"origin":1,"destination":1,"weight":-2.189322345731447},{"layer":0,"origin":1,"destination":2,"weight":-0.37810746751355634},{"layer":0,"origin":1,"destination":3,"weight":-3.946608346435865},{"layer":0,"origin":1,"destination":4,"weight":0.508072203730123},{"layer":0,"origin":1,"destination":5,"weight":0.7630715499507151},{"layer":0,"origin":1,"destination":6,"weight":-7.977746502735063},{"layer":0,"origin":1,"destination":7,"weight":-2.0127694343620655},{"layer":0,"origin":1,"destination":8,"weight":2.5967350352379763},{"layer":0,"origin":1,"destination":9,"weight":0.11684233093869038},{"layer":0,"origin":1,"destination":10,"weight":1.4756283605019418},{"layer":0,"origin":1,"destination":11,"weight":-3.393726882126208},{"layer":0,"origin":1,"destination":12,"weight":2.5578065230371583},{"layer":0,"origin":1,"destination":13,"weight":1.673765172292175},{"layer":0,"origin":1,"destination":14,"weight":-6.183376229361705},{"layer":0,"origin":1,"destination":15,"weight":0.6395099914827812},{"layer":0,"origin":1,"destination":16,"weight":-1.3437970478452506},{"layer":0,"origin":1,"destination":17,"weight":3.3058400247422726},{"layer":0,"origin":1,"destination":18,"weight":1.159050496341356},{"layer":0,"origin":1,"destination":19,"weight":0.9385436382547087},{"layer":0,"origin":2,"destination":0,"weight":-2.5568616831863626},{"layer":0,"origin":2,"destination":1,"weight":-2.564348585320604},{"layer":0,"origin":2,"destination":2,"weight":-0.4177525530824946},{"layer":0,"origin":2,"destination":3,"weight":-0.2063795630414403},{"layer":0,"origin":2,"destination":4,"weight":1.361668736552653},{"layer":0,"origin":2,"destination":5,"weight":0.7989346635514126},{"layer":0,"origin":2,"destination":6,"weight":0.7780989544129913},{"layer":0,"origin":2,"destination":7,"weight":1.2080035302099004},{"layer":0,"origin":2,"destination":8,"weight":-3.3121969586751994},{"layer":0,"origin":2,"destination":9,"weight":-6.388354111749356},{"layer":0,"origin":2,"destination":10,"weight":-0.36366044486401206},{"layer":0,"origin":2,"destination":11,"weight":0.5115902922684876},{"layer":0,"origin":2,"destination":12,"weight":-1.4385192336137682},{"layer":0,"origin":2,"destination":13,"weight":3.38568649414624},{"layer":0,"origin":2,"destination":14,"weight":1.251262322968994},{"layer":0,"origin":2,"destination":15,"weight":-6.680583354058324},{"layer":0,"origin":2,"destination":16,"weight":5.292939863538278},{"layer":0,"origin":2,"destination":17,"weight":-0.6592350418294237},{"layer":0,"origin":2,"destination":18,"weight":1.366709986511249},{"layer":0,"origin":2,"destination":19,"weight":1.9107025423037096},{"layer":0,"origin":3,"destination":0,"weight":0.6409883865672837},{"layer":0,"origin":3,"destination":1,"weight":3.5894459317613165},{"layer":0,"origin":3,"destination":2,"weight":0.08186029470325024},{"layer":0,"origin":3,"destination":3,"weight":-0.28490761406001014},{"layer":0,"origin":3,"destination":4,"weight":1.057048596133386},{"layer":0,"origin":3,"destination":5,"weight":-0.3352785278009371},{"layer":0,"origin":3,"destination":6,"weight":1.35348248503422},{"layer":0,"origin":3,"destination":7,"weight":2.9150588449635113},{"layer":0,"origin":3,"destination":8,"weight":2.4802458933709857},{"layer":0,"origin":3,"destination":9,"weight":0.49021902588359},{"layer":0,"origin":3,"destination":10,"weight":0.23792218902648463},{"layer":0,"origin":3,"destination":11,"weight":2.1845574165077117},{"layer":0,"origin":3,"destination":12,"weight":-0.9358914478660291},{"layer":0,"origin":3,"destination":13,"weight":-6.557070498502342},{"layer":0,"origin":3,"destination":14,"weight":-0.4809513665192753},{"layer":0,"origin":3,"destination":15,"weight":0.6524311105792089},{"layer":0,"origin":3,"destination":16,"weight":-0.8878711724892231},{"layer":0,"origin":3,"destination":17,"weight":-4.019915890000855},{"layer":0,"origin":3,"destination":18,"weight":1.1733691341612345},{"layer":0,"origin":3,"destination":19,"weight":1.538469623150465},{"layer":0,"origin":4,"destination":0,"weight":-2.162130012880423},{"layer":0,"origin":4,"destination":1,"weight":-0.6683467113193144},{"layer":0,"origin":4,"destination":2,"weight":0.7221809959398239},{"layer":0,"origin":4,"destination":3,"weight":-3.1729677750277747},{"layer":0,"origin":4,"destination":4,"weight":2.1815302117932407},{"layer":0,"origin":4,"destination":5,"weight":2.842040336911434},{"layer":0,"origin":4,"destination":6,"weight":0.2899616634422381},{"layer":0,"origin":4,"destination":7,"weight":0.4133094352276812},{"layer":0,"origin":4,"destination":8,"weight":1.0337395945407706},{"layer":0,"origin":4,"destination":9,"weight":-0.38428166463967484},{"layer":0,"origin":4,"destination":10,"weight":3.967335713858174},{"layer":0,"origin":4,"destination":11,"weight":-0.4399394761545056},{"layer":0,"origin":4,"destination":12,"weight":-0.7595342154006044},{"layer":0,"origin":4,"destination":13,"weight":-1.828685101471723},{"layer":0,"origin":4,"destination":14,"weight":-2.049804554866843},{"layer":0,"origin":4,"destination":15,"weight":-0.4533458139739335},{"layer":0,"origin":4,"destination":16,"weight":-0.11056540283771144},{"layer":0,"origin":4,"destination":17,"weight":-0.8068666315945431},{"layer":0,"origin":4,"destination":18,"weight":3.0196264813938587},{"layer":0,"origin":4,"destination":19,"weight":1.3645914776402763},{"layer":0,"origin":5,"destination":0,"weight":-2.610662511337601},{"layer":0,"origin":5,"destination":1,"weight":1.0621736775736423},{"layer":0,"origin":5,"destination":2,"weight":-0.8381569138154012},{"layer":0,"origin":5,"destination":3,"weight":3.8470604656639926},{"layer":0,"origin":5,"destination":4,"weight":-0.7960402557908239},{"layer":0,"origin":5,"destination":5,"weight":-0.47615150752494106},{"layer":0,"origin":5,"destination":6,"weight":3.6520578639228547},{"layer":0,"origin":5,"destination":7,"weight":-0.31788967193184847},{"layer":0,"origin":5,"destination":8,"weight":-0.3658679198844757},{"layer":0,"origin":5,"destination":9,"weight":0.16042742899210702},{"layer":0,"origin":5,"destination":10,"weight":0.1349085373174184},{"layer":0,"origin":5,"destination":11,"weight":0.9476561132828284},{"layer":0,"origin":5,"destination":12,"weight":-1.680412924422265},{"layer":0,"origin":5,"destination":13,"weight":-0.5031233267411643},{"layer":0,"origin":5,"destination":14,"weight":3.8532045571901277},{"layer":0,"origin":5,"destination":15,"weight":-0.1561947748692081},{"layer":0,"origin":5,"destination":16,"weight":0.6603147998906336},{"layer":0,"origin":5,"destination":17,"weight":-1.3749800026170405},{"layer":0,"origin":5,"destination":18,"weight":-1.0676651417649536},{"layer":0,"origin":5,"destination":19,"weight":-0.21758274025910182},{"layer":0,"origin":6,"destination":0,"weight":1.7585407965011324},{"layer":0,"origin":6,"destination":1,"weight":1.5306968662510272},{"layer":0,"origin":6,"destination":2,"weight":-0.8716516029056974},{"layer":0,"origin":6,"destination":3,"weight":-0.054075365428793064},{"layer":0,"origin":6,"destination":4,"weight":-0.8821694710898914},{"layer":0,"origin":6,"destination":5,"weight":-0.6216817564665224},{"layer":0,"origin":6,"destination":6,"weight":-1.67680716982441},{"layer":0,"origin":6,"destination":7,"weight":-0.10502565019139797},{"layer":0,"origin":6,"destination":8,"weight":2.9408720599425435},{"layer":0,"origin":6,"destination":9,"weight":3.852118771385826},{"layer":0,"origin":6,"destination":10,"weight":-2.0910297258020734},{"layer":0,"origin":6,"destination":11,"weight":-0.19406332017661504},{"layer":0,"origin":6,"destination":12,"weight":1.3671770101964125},{"layer":0,"origin":6,"destination":13,"weight":-2.6356152205658794},{"layer":0,"origin":6,"destination":14,"weight":-0.833773353025792},{"layer":0,"origin":6,"destination":15,"weight":4.058726367473899},{"layer":0,"origin":6,"destination":16,"weight":-3.217760607171787},{"layer":0,"origin":6,"destination":17,"weight":0.31741577050338754},{"layer":0,"origin":6,"destination":18,"weight":-0.6913496672503225},{"layer":0,"origin":6,"destination":19,"weight":-1.8423589882042226},{"layer":0,"origin":7,"destination":0,"weight":-1.0646752541193436},{"layer":0,"origin":7,"destination":1,"weight":-3.143528646140453},{"layer":0,"origin":7,"destination":2,"weight":-0.7417965527836555},{"layer":0,"origin":7,"destination":3,"weight":-2.4582688944462032},{"layer":0,"origin":7,"destination":4,"weight":-1.4364023335108407},{"layer":0,"origin":7,"destination":5,"weight":-1.515632850389843},{"layer":0,"origin":7,"destination":6,"weight":-2.0311004187004826},{"layer":0,"origin":7,"destination":7,"weight":-2.1334756195777222},{"layer":0,"origin":7,"destination":8,"weight":-1.4987066313596833},{"layer":0,"origin":7,"destination":9,"weight":-1.6321976479346898},{"layer":0,"origin":7,"destination":10,"weight":-1.1113598528966457},{"layer":0,"origin":7,"destination":11,"weight":-1.5286755223316353},{"layer":0,"origin":7,"destination":12,"weight":0.9172116157600486},{"layer":0,"origin":7,"destination":13,"weight":4.159630162088623},{"layer":0,"origin":7,"destination":14,"weight":-1.536079577823244},{"layer":0,"origin":7,"destination":15,"weight":-1.5809239228509748},{"layer":0,"origin":7,"destination":16,"weight":1.4045375394554382},{"layer":0,"origin":7,"destination":17,"weight":2.725790832598216},{"layer":0,"origin":7,"destination":18,"weight":-2.061736455176065},{"layer":0,"origin":7,"destination":19,"weight":-1.0851156153007282},{"layer":0,"origin":8,"destination":0,"weight":-1.5323517127597068},{"layer":0,"origin":8,"destination":1,"weight":-1.2786650646872473},{"layer":0,"origin":8,"destination":2,"weight":0.4316184634549077},{"layer":0,"origin":8,"destination":3,"weight":-1.5060314917397764},{"layer":0,"origin":8,"destination":4,"weight":-0.6168929810666448},{"layer":0,"origin":8,"destination":5,"weight":-0.9327299125807159},{"layer":0,"origin":8,"destination":6,"weight":-0.825000810050781},{"layer":0,"origin":8,"destination":7,"weight":1.122274005265634},{"layer":0,"origin":8,"destination":8,"weight":0.6212401597420559},{"layer":0,"origin":8,"destination":9,"weight":-1.082554288110361},{"layer":0,"origin":8,"destination":10,"weight":-1.2882083718326827},{"layer":0,"origin":8,"destination":11,"weight":0.020564387640181384},{"layer":0,"origin":8,"destination":12,"weight":-1.1508606883162031},{"layer":0,"origin":8,"destination":13,"weight":-3.4501718146262093},{"layer":0,"origin":8,"destination":14,"weight":-1.555334810730316},{"layer":0,"origin":8,"destination":15,"weight":-1.6360231230346156},{"layer":0,"origin":8,"destination":16,"weight":1.6695707129522286},{"layer":0,"origin":8,"destination":17,"weight":-1.43034352962583},{"layer":0,"origin":8,"destination":18,"weight":-0.7264986356054784},{"layer":0,"origin":8,"destination":19,"weight":-0.3478965369945533},{"layer":1,"origin":0,"destination":0,"weight":-1.6281447715728086},{"layer":1,"origin":0,"destination":1,"weight":-5.1348170574403476},{"layer":1,"origin":0,"destination":2,"weight":0.44783044865641797},{"layer":1,"origin":0,"destination":3,"weight":-1.1208142334636613},{"layer":1,"origin":1,"destination":0,"weight":-5.036275796510997},{"layer":1,"origin":1,"destination":1,"weight":4.705740036792533},{"layer":1,"origin":1,"destination":2,"weight":2.6852478672414617},{"layer":1,"origin":1,"destination":3,"weight":-2.8475921628507215},{"layer":1,"origin":2,"destination":0,"weight":1.7406884966489122},{"layer":1,"origin":2,"destination":1,"weight":0.18419023492935038},{"layer":1,"origin":2,"destination":2,"weight":-0.5263899729610145},{"layer":1,"origin":2,"destination":3,"weight":-0.35446147993417365},{"layer":1,"origin":3,"destination":0,"weight":-3.3976330732452844},{"layer":1,"origin":3,"destination":1,"weight":3.995801260946979},{"layer":1,"origin":3,"destination":2,"weight":-4.598848317117561},{"layer":1,"origin":3,"destination":3,"weight":-1.9592250550872201},{"layer":1,"origin":4,"destination":0,"weight":2.1431893809303353},{"layer":1,"origin":4,"destination":1,"weight":-2.538798317518137},{"layer":1,"origin":4,"destination":2,"weight":-1.662525339778423},{"layer":1,"origin":4,"destination":3,"weight":-3.5376197598493953},{"layer":1,"origin":5,"destination":0,"weight":2.864304955157786},{"layer":1,"origin":5,"destination":1,"weight":-2.461810471035198},{"layer":1,"origin":5,"destination":2,"weight":-0.9946553883286025},{"layer":1,"origin":5,"destination":3,"weight":-3.237131051021215},{"layer":1,"origin":6,"destination":0,"weight":-3.5194596597391934},{"layer":1,"origin":6,"destination":1,"weight":5.0670316575791485},{"layer":1,"origin":6,"destination":2,"weight":-6.8749603451756585},{"layer":1,"origin":6,"destination":3,"weight":-3.9237148931656547},{"layer":1,"origin":7,"destination":0,"weight":1.4990805991371934},{"layer":1,"origin":7,"destination":1,"weight":0.510766411456303},{"layer":1,"origin":7,"destination":2,"weight":-1.7733614339520503},{"layer":1,"origin":7,"destination":3,"weight":-3.2877275422168255},{"layer":1,"origin":8,"destination":0,"weight":3.768630938682009},{"layer":1,"origin":8,"destination":1,"weight":-3.9501129837883733},{"layer":1,"origin":8,"destination":2,"weight":2.8473405336494717},{"layer":1,"origin":8,"destination":3,"weight":-2.6989754619094275},{"layer":1,"origin":9,"destination":0,"weight":-2.7528574904140988},{"layer":1,"origin":9,"destination":1,"weight":-1.1360212857843026},{"layer":1,"origin":9,"destination":2,"weight":4.638106781123086},{"layer":1,"origin":9,"destination":3,"weight":-5.05640218469846},{"layer":1,"origin":10,"destination":0,"weight":4.564802164609658},{"layer":1,"origin":10,"destination":1,"weight":-5.3848400580440785},{"layer":1,"origin":10,"destination":2,"weight":-2.0121854689531116},{"layer":1,"origin":10,"destination":3,"weight":-4.213609739894393},{"layer":1,"origin":11,"destination":0,"weight":-0.38559528050917685},{"layer":1,"origin":11,"destination":1,"weight":1.2121123913605572},{"layer":1,"origin":11,"destination":2,"weight":-2.653712134369636},{"layer":1,"origin":11,"destination":3,"weight":-2.544605602893765},{"layer":1,"origin":12,"destination":0,"weight":-3.045415091259635},{"layer":1,"origin":12,"destination":1,"weight":-2.692563453399544},{"layer":1,"origin":12,"destination":2,"weight":1.0827401287350071},{"layer":1,"origin":12,"destination":3,"weight":0.1555324890630922},{"layer":1,"origin":13,"destination":0,"weight":-6.983613915992496},{"layer":1,"origin":13,"destination":1,"weight":-4.416035954022274},{"layer":1,"origin":13,"destination":2,"weight":-5.692698409208116},{"layer":1,"origin":13,"destination":3,"weight":6.063279172442762},{"layer":1,"origin":14,"destination":0,"weight":-5.007692154240602},{"layer":1,"origin":14,"destination":1,"weight":4.11987536602507},{"layer":1,"origin":14,"destination":2,"weight":-6.244262953624608},{"layer":1,"origin":14,"destination":3,"weight":-1.9691861962348303},{"layer":1,"origin":15,"destination":0,"weight":-4.221543941952039},{"layer":1,"origin":15,"destination":1,"weight":-1.6148870626529719},{"layer":1,"origin":15,"destination":2,"weight":4.728864486144577},{"layer":1,"origin":15,"destination":3,"weight":-5.275891892954545},{"layer":1,"origin":16,"destination":0,"weight":0.8458636798008644},{"layer":1,"origin":16,"destination":1,"weight":1.7541546209044927},{"layer":1,"origin":16,"destination":2,"weight":-4.785171851303778},{"layer":1,"origin":16,"destination":3,"weight":4.375454334816702},{"layer":1,"origin":17,"destination":0,"weight":-2.117854296431801},{"layer":1,"origin":17,"destination":1,"weight":-4.6662069085221605},{"layer":1,"origin":17,"destination":2,"weight":0.5140750688507387},{"layer":1,"origin":17,"destination":3,"weight":3.0092182890852213},{"layer":1,"origin":18,"destination":0,"weight":3.6834730527773125},{"layer":1,"origin":18,"destination":1,"weight":-4.369016878261946},{"layer":1,"origin":18,"destination":2,"weight":-2.104753534765042},{"layer":1,"origin":18,"destination":3,"weight":-4.888603755335016},{"layer":1,"origin":19,"destination":0,"weight":2.3282098154496067},{"layer":1,"origin":19,"destination":1,"weight":-3.935536766119961},{"layer":1,"origin":19,"destination":2,"weight":-3.1058923900024347},{"layer":1,"origin":19,"destination":3,"weight":-2.369258377562535},{"layer":1,"origin":20,"destination":0,"weight":-1.2417776310549165},{"layer":1,"origin":20,"destination":1,"weight":-1.5363156792177857},{"layer":1,"origin":20,"destination":2,"weight":-0.5938593191519558},{"layer":1,"origin":20,"destination":3,"weight":-0.230596293063432}]}';

const localBoardWidth = boardWidth;
const localBoardHeight = boardHeight;

void main(List args) {
//  final perceptron = Perceptron.fromJson(jsonData, 4);
  final perceptron = Perceptron([8, 20, 4], 1);
  final _selector = GameSelector();
  final data = <TrainingData>[];
  for (var i=0; i<1000000; i++) {
    final state = createGameState(i%5 == 0? 1 : i%7 == 0? 2 : 0);
    final possibleTurns = <Direction>[];
    final goodTurns = <Direction>[];
    final input = _selector.getInputCondition(state);
    for (var direction in Direction.values) {
      if (direction == Direction.up) {
        if (input.upObstacle == 1) {
          continue;
        }
      }
      if (direction == Direction.left) {
        if (input.leftObstacle == 1) {
          continue;
        }
      }
      if (direction == Direction.down) {
        if (input.downObstacle == 1) {
          continue;
        }
      }
      if (direction == Direction.right) {
        if (input.rightObstacle == 1) {
          continue;
        }
      }
      if (_isGoodDirection(direction, input)) {
        goodTurns.add(direction);
        break;
      }
      possibleTurns.add(direction);
    }
    if (goodTurns.isEmpty) {
      if (possibleTurns.isEmpty) {
        continue;
      }
      else {
        goodTurns.add(possibleTurns[0]);
      }
    }
    final changedDirection = goodTurns.first;

    data.add(TrainingData(convertInputConditionToArray(input), convertDirectionToOutputArray(changedDirection)));
  }
  perceptron.train(data);
  print(perceptron.toJson());
}

bool _isGoodDirection(Direction direction, InputCondition input) {
  if (direction == Direction.up && input.foodDirection.up == 1) {
    return true;
  }
  if (direction == Direction.left && input.foodDirection.left == 1) {
    return true;
  }
  if (direction == Direction.down && input.foodDirection.down == 1) {
    return true;
  }
  if (direction == Direction.right && input.foodDirection.right == 1) {
    return true;
  }
  return false;
}

GameState createGameState(int mode) {
  final snake = mode == 0? _createRandomSnakeCoords() : mode == 1? _createBorderSnakeCoords() : _createTightSnakeCoords();
  final food = _createFoodCoords();
  if (snake.contains(food)) {
    snake.remove(food);
  }
  return GameState((c) =>
  c
    ..isHumanMode = true
    ..currentPhase = GamePhase.notStarted
    ..snakeCoords.replace([])
    ..currentDirection = Direction.parse(rand.nextInt(4))
    ..prevDirection = Direction.up
    ..foodCoords = food
    ..inputConditions.replace([])
    ..movesCount = 0
    ..snakeCoords.replace(snake)
    ..outputConditions.replace([]));
}

List<int> _createRandomSnakeCoords() {
  final result = <int>[];
  final x = rand.nextInt(localBoardWidth);
  final y = rand.nextInt(localBoardHeight-1) + 1;
  for (var i = localBoardHeight - y; i < localBoardHeight - y + 1; i++) {
    result.add(i * localBoardWidth + x);
  }
  for (var i = 0; i < localBoardHeight * localBoardWidth / 3; i++) {
    result.add(rand.nextInt(localBoardWidth) * localBoardHeight + rand.nextInt(localBoardWidth));
  }
  return result;
}

List<int> _createTightSnakeCoords() {
  final data = [0, 0, 0, 0];
  final obstacles = rand.nextInt(2)+2;
  for (var i=0; i<obstacles; i++) {
    var index;
    do {
      index = rand.nextInt(4);
    } while (data[index] == 1);
    data[index] = 1;
  }
  final result = <int>[];
  var point = localBoardHeight~/2 * localBoardWidth + localBoardWidth~/2;
  result.add(point);
  if (data[0] == 1) {
    result.add(point - 1);
  }
  if (data[1] == 1) {
    result.add(point - localBoardWidth);
  }
  if (data[2] == 1) {
    result.add(point + 1);
  }
  if (data[3] == 1) {
    result.add(point + localBoardWidth);
  }
  return result;
}

List<int> _createBorderSnakeCoords() {
  final result = <int>[];
  final x = rand.nextInt(localBoardWidth);
  final y = rand.nextInt(localBoardHeight);
  final direction = rand.nextInt(2);
  final column = rand.nextInt(2);
  if (direction == 0) {
    if (column == 0) {
      result.add(x);
      result.add(x+localBoardWidth);
    }
    else {
      result.add(x + (localBoardHeight-1) * localBoardWidth);
      result.add(x + (localBoardHeight-2) * localBoardWidth);
    }
  }
  else {
    if (column == 0) {
      result.add(y*localBoardWidth);
      result.add(y*localBoardWidth+1);
    }
    else {
      result.add(y*localBoardWidth + localBoardWidth-1);
      result.add(y*localBoardWidth + localBoardWidth-2);
    }
  }
  for (var i = 0; i < localBoardHeight * localBoardWidth / 6; i++) {
    result.add(rand.nextInt(localBoardWidth) * localBoardHeight + rand.nextInt(localBoardWidth));
  }
  return result;
}

int _createFoodCoords() {
  return rand.nextInt(localBoardWidth * localBoardHeight);
}