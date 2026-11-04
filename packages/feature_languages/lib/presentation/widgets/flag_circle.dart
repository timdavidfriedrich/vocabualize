import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

const flagCircleSize = Spacing.xxxl;
const largeFlagCircleSize = Spacing.xxxl + Spacing.xs;

class const FlagCircle({
  super.key,
  required final Language _language,
  required final Color _color,
  final double _size = flagCircleSize,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: _color),
      child: Text(_language.toFlag(), style: context.t.titleLarge),
    );
  }
}
