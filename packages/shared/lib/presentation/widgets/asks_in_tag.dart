import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

class const AsksInTag({
  super.key,
  required final Language _language,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xxxs),
      decoration: BoxDecoration(
        border: Border.all(color: context.c.primary),
        borderRadius: BorderRadius.circular(Spacing.radiusS),
      ),
      child: Text(
        context.s.languagesAsksInLabel(_language.toFlag()),
        style: context.t.labelMedium?.copyWith(color: context.c.primary),
      ),
    );
  }
}
