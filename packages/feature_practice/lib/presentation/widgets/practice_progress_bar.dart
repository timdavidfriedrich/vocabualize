import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/practice_bloc.dart';
import 'package:feature_practice/presentation/practice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

class const PracticeProgressBar({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PracticeBloc, PracticeState, ({int done, int total})>(
      selector: (state) => switch (state) {
        PracticeActive(:final doneCount, :final totalCount) => (done: doneCount, total: totalCount),
        _ => (done: 0, total: 0),
      },
      builder: (context, progress) => Row(
        children: [
          IconButton(
            onPressed: context.closeScreen,
            icon: const Icon(Icons.close_rounded),
          ),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(Spacing.radiusS),
              value: progress.total == 0 ? 0 : progress.done / progress.total,
              minHeight: Spacing.s,
              color: context.c.primary,
              backgroundColor: context.c.surfaceContainerLow,
            ),
          ),
          const SizedBox(width: Spacing.xl),
          Text(
            context.s.loadingProgressLabel(progress.done, progress.total),
            textAlign: TextAlign.center,
            style: context.t.bodyLarge?.copyWith(
              color: context.c.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: Spacing.m),
        ],
      ),
    );
  }
}
