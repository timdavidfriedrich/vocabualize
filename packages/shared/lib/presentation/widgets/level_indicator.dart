import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/vocabulary_level_extensions.dart';

class const LevelIndicator({
  super.key,
  required final VocabularyLevel _level,
  final EdgeInsetsGeometry _margin = EdgeInsets.zero,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      width: Spacing.xxxs,
      decoration: BoxDecoration(
        color: _level.toColor(context),
        borderRadius: BorderRadius.circular(Spacing.radiusS),
      ),
    );
  }
}
