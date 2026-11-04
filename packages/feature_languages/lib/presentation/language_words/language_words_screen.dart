import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/language_words/language_words_bloc.dart';
import 'package:feature_languages/presentation/language_words/language_words_event.dart';
import 'package:feature_languages/presentation/language_words/language_words_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/page_app_bar.dart';
import 'package:shared/presentation/widgets/segmented_bar.dart';
import 'package:shared/presentation/widgets/selection_indicators.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _importThumbnailSize = Spacing.xxxl - Spacing.xs;
const _manageThumbnailSize = Spacing.xxxl;
const _addedTint = 0.5;

class const LanguageWordsScreen({
  super.key,
  required final Language _language,
  required final bool _isAdding,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageWordsBloc, LanguageWordsState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (_, LanguageWordsSaved()) => true,
        (LanguageWordsEditing(error: null), LanguageWordsEditing(error: _?)) => true,
        _ => false,
      },
      listener: (context, state) => switch (state) {
        LanguageWordsSaved() => context.closeScreen(),
        LanguageWordsEditing(:final error?) => context.showToast(error.toMessage(context)),
        LanguageWordsEditing() || LanguageWordsLoading() || LanguageWordsFailure() => null,
      },
      child: Scaffold(
        appBar: PageAppBar(
          title: _isAdding ? null : Text(context.s.languageWordsManageTitle),
          actions: [
            if (!_isAdding)
              Padding(
                padding: const EdgeInsets.only(right: Spacing.m),
                child: Text(_language.toFlag(), style: context.t.titleLarge),
              ),
          ],
        ),
        body: BlocBuilder<LanguageWordsBloc, LanguageWordsState>(
          builder: (context, state) => switch (state) {
            LanguageWordsEditing(isAdding: true) => _ImportContent(state: state),
            LanguageWordsEditing() => _ManageContent(state: state),
            LanguageWordsFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            LanguageWordsLoading() || LanguageWordsSaved() => const Center(
              child: CircularProgressIndicator(),
            ),
          },
        ),
      ),
    );
  }
}

class const _ImportContent({
  required final LanguageWordsEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageWordsBloc>();
    final language = _state.language;
    final hasWords = _state.coverage.totalCount > 0;
    return _Layout(
      button: ElevatedButton(
        onPressed: _state.isSaving ? null : () => bloc.add(const LanguageWordsSaveRequested()),
        child: _state.isSaving
            ? const ButtonProgress()
            : Text(context.s.languageWordsImportButton(hasWords ? _state.importCount : 0)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
          child: Text(
            context.s.languageWordsImportTitle(
              "${language.toFlag()} ${language.toShortLabel(context)}",
            ),
            style: context.t.headlineMedium,
          ),
        ),
        const SizedBox(height: Spacing.xxs),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
          child: Text(
            hasWords
                ? context.s.languageWordsImportHint
                : context.s.languageWordsNoWordsHint(language.toShortLabel(context)),
            style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: Spacing.l),
        if (hasWords) ...[
          _OptionCard(
            title: context.s.languageWordsAllOption,
            subtitle: context.s.languagesWordCount(_state.coverage.totalCount),
            isSelected: _state.option == LanguageWordsOption.all,
            onTap: () =>
                bloc.add(const LanguageWordsOptionChanged(option: LanguageWordsOption.all)),
          ),
          const SizedBox(height: Spacing.xs),
          _OptionCard(
            title: context.s.languageWordsSomeCollectionsOption,
            subtitle: context.s.languagesWordCount(_state.preview?.addedCount ?? 0),
            isSelected: _state.option == LanguageWordsOption.choose,
            onTap: () =>
                bloc.add(const LanguageWordsOptionChanged(option: LanguageWordsOption.choose)),
            children: [
              if (_state.option == LanguageWordsOption.choose)
                _Collections(state: _state, thumbnailSize: _importThumbnailSize),
            ],
          ),
          const SizedBox(height: Spacing.xs),
          _OptionCard(
            title: context.s.languageWordsNoneOption,
            subtitle: context.s.languageWordsNoneHint,
            isSelected: _state.option == LanguageWordsOption.none,
            onTap: () =>
                bloc.add(const LanguageWordsOptionChanged(option: LanguageWordsOption.none)),
          ),
        ],
      ],
    );
  }
}

class const _ManageContent({
  required final LanguageWordsEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageWordsBloc>();
    return _Layout(
      button: ElevatedButton(
        onPressed: _state.isSaving || !_state.hasChanges
            ? null
            : () => bloc.add(const LanguageWordsSaveRequested()),
        child: _state.isSaving ? const ButtonProgress() : Text(context.s.languageWordsSaveButton),
      ),
      children: [
        _SummaryCard(state: _state),
        const SizedBox(height: Spacing.l),
        _Collections(state: _state, thumbnailSize: _manageThumbnailSize),
      ],
    );
  }
}

class const _Layout({
  required final List<Widget> _children,
  required final Widget _button,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: Spacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.xs, Spacing.m, Spacing.xl),
              children: _children,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
            child: _button,
          ),
        ],
      ),
    );
  }
}

class const _OptionCard({
  required final String _title,
  required final String _subtitle,
  required final bool _isSelected,
  required final VoidCallback _onTap,
  final List<Widget> _children = const [],
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isSelected ? context.c.primaryContainer : context.c.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _onTap,
            child: Padding(
              padding: const EdgeInsets.all(Spacing.m),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_title, style: context.t.titleMedium),
                        Text(
                          _subtitle,
                          style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  RadioIndicator(isSelected: _isSelected),
                ],
              ),
            ),
          ),
          if (_children.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.m),
              child: Column(children: _children),
            ),
        ],
      ),
    );
  }
}

class const _SummaryCard({
  required final LanguageWordsEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coverage = _state.coverage;
    final added = _state.preview?.addedCount ?? 0;
    final removed = _state.preview?.removedCount ?? 0;
    final result = _state.resultCount;
    return Container(
      padding: const EdgeInsets.all(Spacing.l),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                coverage.inLanguageCount.toCountLabel(context),
                style: context.t.displaySmall?.copyWith(
                  color: context.c.outline,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: Spacing.m),
              Icon(Icons.arrow_forward_rounded, color: context.c.primary, size: Spacing.iconXl),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Text(
                  result.toCountLabel(context),
                  style: context.t.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: Spacing.xxs,
                children: [
                  if (added > 0)
                    _ChangeChip(
                      label: context.s.languageWordsAddedLabel(added.toCountLabel(context)),
                      color: context.c.primaryContainer,
                      textColor: context.c.primary,
                    ),
                  if (removed > 0)
                    _ChangeChip(
                      label: context.s.languageWordsRemovedLabel(removed.toCountLabel(context)),
                      color: context.c.errorContainer,
                      textColor: context.c.error,
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: Spacing.l),
          SegmentedBar(
            total: coverage.totalCount,
            parts: [
              SegmentedBarPart(value: coverage.inLanguageCount - removed, color: context.c.primary),
              SegmentedBarPart(
                value: added,
                color: Color.lerp(context.c.primary, context.c.onPrimary, _addedTint)!,
              ),
            ],
          ),
          const SizedBox(height: Spacing.m),
          Text(
            context.s.languageWordsImportedCount(result, coverage.totalCount),
            style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class const _ChangeChip({
  required final String _label,
  required final Color _color,
  required final Color _textColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxs),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(Spacing.radiusM),
      ),
      child: Text(_label, style: context.t.labelLarge?.copyWith(color: _textColor)),
    );
  }
}

class const _Collections({
  required final LanguageWordsEditing _state,
  required final double _thumbnailSize,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageWordsBloc>();
    final label = _state.language.toShortLabel(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final collection in _state.coverage.collections)
          if (collection.totalCount > 0)
            _CollectionRow(
              name: collection.tag.name,
              image: _state.images[collection.tag.id],
              thumbnailSize: _thumbnailSize,
              isCompact: _state.isAdding,
              subtitle: _countLabel(
                context,
                collection.totalCount,
                isRemoving: _state.isRemoving(collection.tag.id),
                label: label,
              ),
              isWarning: !_state.isAdding && _state.isRemoving(collection.tag.id),
              isChecked: _state.selection[collection.tag.id] ?? false,
              onTap: () => bloc.add(LanguageWordsCollectionToggled(tagId: collection.tag.id)),
            ),
        if (_state.coverage.untaggedCount > 0)
          _CollectionRow(
            name: context.s.languageWordsUntaggedLabel,
            image: null,
            thumbnailSize: _thumbnailSize,
            isCompact: _state.isAdding,
            subtitle: _countLabel(
              context,
              _state.coverage.untaggedCount,
              isRemoving: _state.isRemovingUntagged,
              label: label,
            ),
            isWarning: !_state.isAdding && _state.isRemovingUntagged,
            isChecked: _state.untagged,
            onTap: () => bloc.add(const LanguageWordsUntaggedToggled()),
          ),
      ],
    );
  }

  String _countLabel(
    BuildContext context,
    int count, {
    required bool isRemoving,
    required String label,
  }) {
    if (_state.isAdding) return count.toCountLabel(context);
    if (isRemoving) return context.s.languageWordsRemovedWarning(count, label);
    return context.s.languagesWordCount(count);
  }
}

class const _CollectionRow({
  required final String _name,
  required final VocabularyImage? _image,
  required final double _thumbnailSize,
  required final bool _isCompact,
  required final String _subtitle,
  required final bool _isWarning,
  required final bool? _isChecked,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subtitleStyle = context.t.bodyLarge?.copyWith(
      color: _isWarning ? context.c.error : context.c.onSurfaceVariant,
    );
    return InkWell(
      onTap: _onTap,
      borderRadius: BorderRadius.circular(Spacing.radiusM),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
        child: Row(
          children: [
            SizedBox.square(
              dimension: _thumbnailSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Spacing.radiusM),
                child: switch (_image) {
                  final image? => VocabularyImageView(
                    image: image,
                    variant: VocabularyImageVariant.thumbnail,
                    displayWidth: _thumbnailSize,
                  ),
                  null => ColoredBox(
                    color: context.c.surfaceContainerHigh,
                    child: Icon(Icons.folder_outlined, color: context.c.onSurfaceVariant),
                  ),
                },
              ),
            ),
            const SizedBox(width: Spacing.m),
            Expanded(
              child: _isCompact
                  ? Text(_name, style: context.t.titleMedium, overflow: TextOverflow.ellipsis)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_name, style: context.t.titleMedium, overflow: TextOverflow.ellipsis),
                        Text(_subtitle, style: subtitleStyle),
                      ],
                    ),
            ),
            if (_isCompact) ...[
              Text(_subtitle, style: subtitleStyle),
              const SizedBox(width: Spacing.m),
            ],
            CheckIndicator(isChecked: _isChecked),
          ],
        ),
      ),
    );
  }
}
