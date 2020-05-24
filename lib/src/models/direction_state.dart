import 'package:meta/meta.dart';

class DirectionState {
  final int left;
  final int right;
  final int up;
  final int down;

  DirectionState({
    @required this.left,
    @required this.right,
    @required this.up,
    @required this.down});
}