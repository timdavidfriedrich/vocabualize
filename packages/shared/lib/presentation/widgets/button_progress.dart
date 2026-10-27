import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

class const ButtonProgress({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: Spacing.iconS,
      child: CircularProgressIndicator(strokeWidth: Spacing.borderWidthMedium),
    );
  }
}
