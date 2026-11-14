import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/translation_fill/translation_fill_cubit.dart';
import 'package:shared/presentation/translation_fill/translation_fill_state.dart';

class const TranslationLimitNotice({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationFillCubit, TranslationFillState>(
      builder: (context, state) => switch (state) {
        TranslationFillState.idle => const SizedBox.shrink(),
        TranslationFillState.limitReached => Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.xs, Spacing.s, Spacing.xs, 0),
          child: Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: Spacing.iconS,
                color: context.c.onSurfaceVariant,
              ),
              const SizedBox(width: Spacing.xs),
              Expanded(
                child: Text(
                  context.s.homeTranslationLimitMessage,
                  style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
      },
    );
  }
}
