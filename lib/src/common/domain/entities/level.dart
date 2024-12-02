// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vocabualize/config/themes/level_palette.dart';
import 'package:vocabualize/constants/due_algorithm_constants.dart';

abstract class Level {
  final double value;
  abstract final Color color;

  const Level._(this.value);

  factory Level({required double value}) {
    const limit = DueAlgorithmConstants.levelLimit;
    return switch (value) {
      >= limit => ExpertLevel._(value),
      >= (limit / 3) * 2 => AdvancedLevel._(value),
      > limit / 3 => BeginnerLevel._(value),
      _ => NoviceLevel._(value),
    };
  }

  Level copyWith({double? value}) {
    return Level(value: value ?? this.value);
  }

  @override
  String toString() {
    return 'Level(value: $value, color: $color)';
  }
}

class NoviceLevel extends Level {
  const NoviceLevel._(super.value) : super._();
  @override
  final Color color = LevelPalette.novice;
}

class BeginnerLevel extends Level {
  const BeginnerLevel._(super.value) : super._();
  @override
  final Color color = LevelPalette.beginner;
}

class AdvancedLevel extends Level {
  const AdvancedLevel._(super.value) : super._();
  @override
  final Color color = LevelPalette.advanced;
}

class ExpertLevel extends Level {
  const ExpertLevel._(super.value) : super._();
  @override
  final Color color = LevelPalette.expert;
}
