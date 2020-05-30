import 'dart:io';
import 'dart:math';

import 'package:perceptron/perceptron.dart';

void main(List args) async {
  final imageData = File('train-images-idx3-ubyte').readAsBytesSync();
  final imageLabels = File('train-labels-idx1-ubyte').readAsBytesSync();
  var imagePositionCounter = 4;
  var labelPositionCounter = 8;
  final total = _readLong(imageData, imagePositionCounter);
  imagePositionCounter += 4;
  final width = _readLong(imageData, imagePositionCounter);
  imagePositionCounter += 4;
  final height = _readLong(imageData, imagePositionCounter);
  imagePositionCounter += 4;
  print('$total, $width x $height');
  final perceptron = Perceptron([width * height, 16, 10], 5);
  final data = <TrainingData>[];
  for (var i=0; i<total; i++) {
    final inputs = <double>[];
    for (var j=0; j<width * height; j++) {
      inputs.add(imageData[imagePositionCounter] < 128? 0.0 : 1.0);
      imagePositionCounter++;
    }
    final outputs = <double>[];
    for (var j=0; j<10; j++) {
      outputs.add(imageLabels[labelPositionCounter] == j? 1.0 : 0.0);
    }
    labelPositionCounter++;
    data.add(TrainingData(inputs, outputs));
    if (i % 200 == 0) {
      perceptron.train(data);
      final file = File('training.prg');
      file.writeAsStringSync('Trained cases: $i\n');
      file.writeAsStringSync(perceptron.toJson());
      file.writeAsStringSync('\n', flush: true);
      data.clear();
    }
  }
  perceptron.train(data);
  final file = File('training.prg');
  file.writeAsStringSync('Trained cases: $total\n');
  file.writeAsStringSync(perceptron.toJson());
  file.writeAsStringSync('\n', flush: true);
  print(perceptron.toJson());
}

int _readLong(List<int> data, int counter) {
  return data[counter] * 256 * 256 * 256 + data[counter+1] * 256 * 256 + data[counter+2] * 256 + data[counter+3];
}

