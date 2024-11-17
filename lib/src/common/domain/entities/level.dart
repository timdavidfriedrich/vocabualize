// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/constants/due_algorithm_constants.dart';

enum LevelType { novice, beginner, advanced, expert }

class Level {
  final double _valueLimit = DueAlgorithmConstants.levelLimit;
  final double value;

  const Level({this.value = 0.0});
  const Level.withValue({required this.value});

  Color get color {
    if (value >= _valueLimit) {
      return LevelPalette.expert;
    } else if (value >= (_valueLimit / 3) * 2) {
      return LevelPalette.advanced;
    } else if (value > _valueLimit / 3) {
      return LevelPalette.beginner;
    } else {
      return LevelPalette.novice;
    }
  }

  /* // TODO: Move this vocabulary usecase, repo, etc.
  void add(double difference) {
    if (difference.isNegative) {
      if (value > difference.abs()) value -= difference.abs();
    } else {
      if (value <= _valueLimit) value += difference;
    }
  }
  */

  @override
  String toString() => 'Level(value: $value)';

  Level copyWith({
    double? value,
  }) {
    return Level(
      value: value ?? this.value,
    );
  }
}
