import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_bloc.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_event.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_state.dart';
import 'package:feature_practice/presentation/extensions/custom_practice_editing_extensions.dart';
import 'package:feature_practice/presentation/widgets/custom_practice_collections_row.dart';
import 'package:feature_practice/presentation/widgets/custom_practice_language_card.dart';
import 'package:feature_practice/presentation/widgets/custom_practice_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/page_app_bar.dart';

class const CustomPracticeScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomPracticeBloc, CustomPracticeState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (_, CustomPracticeLaunched()) => true,
        (CustomPracticeEditing(error: null), CustomPracticeEditing(error: _?)) => true,
        _ => false,
      },
      listener: (context, state) => switch (state) {
        CustomPracticeLaunched() => context.startCustomPractice(),
        CustomPracticeEditing(:final error?) => context.showToast(error.toMessage(context)),
        CustomPracticeEditing() || CustomPracticeLoading() || CustomPracticeFailure() => null,
      },
      child: Scaffold(
        appBar: PageAppBar(closes: true, title: Text(context.s.customPracticeTitle)),
        body: BlocBuilder<CustomPracticeBloc, CustomPracticeState>(
          builder: (context, state) => switch (state) {
            CustomPracticeEditing() => _Content(state: state),
            CustomPracticeFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            CustomPracticeLoading() || CustomPracticeLaunched() => const Center(
              child: CircularProgressIndicator(),
            ),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final CustomPracticeEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final total = _state.totalCount;
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: Spacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.m, Spacing.m, Spacing.xl),
              children: [
                CustomPracticeSummaryCard(state: _state),
                for (final language in _state.activeLanguages) ...[
                  const SizedBox(height: Spacing.s),
                  CustomPracticeLanguageCard(state: _state, language: language),
                ],
                if (_state.tags.isNotEmpty) ...[
                  const SizedBox(height: Spacing.s),
                  CustomPracticeCollectionsRow(state: _state),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
            child: ElevatedButton(
              onPressed: _state.counts == null || _state.isStarting || total == 0
                  ? null
                  : () => _start(context),
              child: _state.isStarting
                  ? const ButtonProgress()
                  : Text(context.s.customPracticeStartButton(total)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _start(BuildContext context) async {
    final bloc = context.read<CustomPracticeBloc>();
    if (_state.hasUnfinishedSession) {
      final isConfirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog.adaptive(
          title: Text(context.s.customPracticeReplaceTitle),
          content: Text(context.s.customPracticeReplaceMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(context.s.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(context.s.customPracticeReplaceButton),
            ),
          ],
        ),
      );
      if (isConfirmed != true) return;
    }
    bloc.add(const CustomPracticeStartRequested());
  }
}
