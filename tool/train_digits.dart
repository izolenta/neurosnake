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
  final watch = Stopwatch();
  for (var i=0; i<total; i++) {
    watch.start();
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
    if (i % 100 == 0) {
      perceptron.train(data);
      final file = File('training.prg').openSync(mode: FileMode.write);
      file.writeStringSync('Trained cases: $i\n');
      file.writeStringSync(perceptron.toJson());
      file.writeStringSync('\n');
      file.closeSync();
      data.clear();
      watch.stop();
      print('handled in ${watch.elapsed.inSeconds} sec');
    }
  }
  perceptron.train(data);
  final file = File('training.prg').openSync(mode: FileMode.write);
  file.writeStringSync('Trained cases: $total\n');
  file.writeStringSync(perceptron.toJson());
  file.writeStringSync('\n');
  file.closeSync();
  print(perceptron.toJson());
}

int _readLong(List<int> data, int counter) {
  return data[counter] * 256 * 256 * 256 + data[counter+1] * 256 * 256 + data[counter+2] * 256 + data[counter+3];
}

