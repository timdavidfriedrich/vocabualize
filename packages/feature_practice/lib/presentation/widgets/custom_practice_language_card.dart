import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_bloc.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_event.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_state.dart';
import 'package:feature_practice/presentation/extensions/custom_practice_editing_extensions.dart';
import 'package:feature_practice/presentation/widgets/count_row.dart';
import 'package:feature_practice/presentation/widgets/words_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

class const CustomPracticeLanguageCard({
  super.key,
  required final CustomPracticeEditing _state,
  required final Language _language,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomPracticeBloc>();
    final isEnabled = _state.enabledLanguages.contains(_language);
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(_language.toFlag(), style: context.t.titleLarge),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Text(
                  _language.toLabel(context),
                  style: context.t.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (_state.activeLanguages.length > 1)
                Switch(
                  value: isEnabled,
                  onChanged: (_) => bloc.add(CustomPracticeLanguageToggled(language: _language)),
                ),
            ],
          ),
          if (isEnabled) ...[
            const SizedBox(height: Spacing.s),
            CountRow(
              leading: WordsToggle(
                isAll: _state.includesAllWords(_language),
                onChanged: () => bloc.add(CustomPracticeAllWordsToggled(language: _language)),
              ),
              count: _state.reviewCountOf(_language),
              maximum: _state.availableReviewCountOf(_language),
              onChanged: (count) => bloc.add(
                CustomPracticeReviewWordsChanged(language: _language, count: count),
              ),
            ),
            if (_state.waitingCountOf(_language) > 0) ...[
              const SizedBox(height: Spacing.xs),
              CountRow(
                leading: Text(
                  context.s.customPracticeNewLabel,
                  style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                ),
                count: _state.newCountOf(_language),
                maximum: _state.waitingCountOf(_language),
                onChanged: (count) => bloc.add(
                  CustomPracticeNewWordsChanged(language: _language, count: count),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
