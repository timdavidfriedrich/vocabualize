import 'package:flutter/material.dart';
import 'package:vocabualize/config/themes/level_palette.dart';

class Level {
  final double _valueLimit = 3.0;
  double value = 0;

  Level();

  Level.withValue({required this.value});

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

  void add(double difference) {
    if (difference.isNegative) {
      if (value > difference.abs()) value -= difference.abs();
    } else {
      if (value <= _valueLimit) value += difference;
    }
  }
}
