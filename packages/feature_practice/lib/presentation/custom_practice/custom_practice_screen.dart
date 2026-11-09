import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_bloc.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_event.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_state.dart';
import 'package:feature_practice/presentation/widgets/collections_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/page_app_bar.dart';
import 'package:shared/presentation/widgets/photo_stack.dart';
import 'package:shared/presentation/widgets/segmented_bar.dart';

const _photoSize = Spacing.xxl + Spacing.xxxs;
const _newTint = 0.5;
const _countStep = 5;
const _countWidth = Spacing.xxxl;
const _legendDotSize = Spacing.s;

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
                _SummaryCard(state: _state),
                for (final language in _state.activeLanguages) ...[
                  const SizedBox(height: Spacing.s),
                  _LanguageCard(state: _state, language: language),
                ],
                if (_state.tags.isNotEmpty) ...[
                  const SizedBox(height: Spacing.s),
                  _CollectionsRow(state: _state),
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

Color _colorOf(BuildContext context, CustomPracticeEditing state, Language language) {
  final colors = [
    context.c.primary,
    context.levels.advanced,
    context.levels.expert,
    context.levels.beginner,
  ];
  final index = state.activeLanguages.indexOf(language);
  return colors[(index < 0 ? 0 : index) % colors.length];
}

Color _newColorOf(BuildContext context, Color color) =>
    Color.lerp(color, context.c.onPrimary, _newTint)!;

class const _SummaryCard({
  required final CustomPracticeEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languages = _state.shownEnabledLanguages;
    final legendCount = languages.fold(
      0,
      (sum, language) => sum + (_state.waitingCountOf(language) > 0 ? 2 : 1),
    );
    return Container(
      padding: const EdgeInsets.all(Spacing.l),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _state.totalCount.toCountLabel(context),
                style: context.t.displayMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: Spacing.s),
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.xs),
                child: Text(
                  context.s.customPracticeWordsLabel(_state.totalCount),
                  style: context.t.titleMedium?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ),
              const Spacer(),
              PhotoStack(
                images: _state.previewImages,
                size: _photoSize,
                borderColor: context.c.surfaceContainerLow,
              ),
            ],
          ),
          if (legendCount > 1) ...[
            const SizedBox(height: Spacing.m),
            SegmentedBar(
              parts: [
                for (final language in languages) ...[
                  SegmentedBarPart(
                    value: _state.reviewCountOf(language),
                    color: _colorOf(context, _state, language),
                  ),
                  SegmentedBarPart(
                    value: _state.newCountOf(language),
                    color: _newColorOf(context, _colorOf(context, _state, language)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: Spacing.m),
            for (final language in languages)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Spacing.xxxs),
                child: Row(
                  children: [
                    Expanded(
                      child: _LegendEntry(
                        color: _colorOf(context, _state, language),
                        language: language,
                        label: _state.includesAllWords(language)
                            ? context.s.customPracticeAllLegend(_state.reviewCountOf(language))
                            : context.s.customPracticeDueLegend(_state.reviewCountOf(language)),
                      ),
                    ),
                    Expanded(
                      child: switch (_state.waitingCountOf(language)) {
                        0 => const SizedBox.shrink(),
                        _ => _LegendEntry(
                          color: _newColorOf(context, _colorOf(context, _state, language)),
                          language: language,
                          label: context.s.customPracticeNewLegend(_state.newCountOf(language)),
                        ),
                      },
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class const _LegendEntry({
  required final Color _color,
  required final Language _language,
  required final String _label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: _legendDotSize,
          height: _legendDotSize,
          decoration: BoxDecoration(shape: BoxShape.circle, color: _color),
        ),
        const SizedBox(width: Spacing.s),
        Text(_language.toFlag(), style: context.t.bodyMedium),
        const SizedBox(width: Spacing.xs),
        Flexible(
          child: Text(_label, style: context.t.bodyLarge, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class const _LanguageCard({
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
            _CountRow(
              leading: _WordsToggle(
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
              _CountRow(
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

class const _CountRow({
  required final Widget _leading,
  required final int _count,
  required final int _maximum,
  required final ValueChanged<int> _onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.s, Spacing.xs, Spacing.xs, Spacing.xs),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXl),
      ),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: _leading,
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: _count <= 0
                ? null
                : () => _onChanged(((_count - 1) ~/ _countStep) * _countStep),
            tooltip: context.s.customPracticeFewerTooltip,
            icon: const Icon(Icons.remove_rounded),
          ),
          SizedBox(
            width: _countWidth,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(_count.toCountLabel(context), style: context.t.headlineSmall),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: _count >= _maximum
                ? null
                : () => _onChanged((_count ~/ _countStep + 1) * _countStep),
            tooltip: context.s.customPracticeMoreTooltip,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}

class const _WordsToggle({
  required final bool _isAll,
  required final VoidCallback _onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(color: context.c.primaryContainer, shape: const StadiumBorder()),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xxxs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ToggleSegment(
              label: context.s.customPracticeDueLabel,
              isSelected: !_isAll,
              onTap: _isAll ? _onChanged : null,
            ),
            _ToggleSegment(
              label: context.s.customPracticeAllWordsOption,
              isSelected: _isAll,
              onTap: _isAll ? null : _onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class const _ToggleSegment({
  required final String _label,
  required final bool _isSelected,
  required final VoidCallback? _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isSelected ? context.c.primary : Colors.transparent,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxs),
          child: Text(
            _label,
            style: context.t.labelLarge?.copyWith(
              color: _isSelected ? context.c.onPrimary : context.c.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class const _CollectionsRow({
  required final CustomPracticeEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final names = [
      for (final tag in _state.tags)
        if (_state.tagIds.contains(tag.id)) tag.name,
    ];
    return Material(
      color: context.c.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _pick(context),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.l),
          child: Row(
            children: [
              Text(context.s.customPracticeCollectionsTitle, style: context.t.titleMedium),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Text(
                  names.isEmpty ? context.s.customPracticeAllOption : names.join(", "),
                  style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(width: Spacing.xs),
              Icon(Icons.chevron_right_rounded, color: context.c.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final bloc = context.read<CustomPracticeBloc>();
    final tagIds = await requestsCollections(
      context,
      tags: _state.tags,
      images: _state.collectionImages,
      counts: _state.collectionCounts,
      selected: _state.tagIds,
    );
    if (tagIds != null) bloc.add(CustomPracticeCollectionsChanged(tagIds: tagIds));
  }
}
