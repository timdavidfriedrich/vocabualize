import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_level_extensions.dart';

const _resultsPadding = EdgeInsets.fromLTRB(Spacing.xxl, Spacing.xs, Spacing.xxl, Spacing.xxxl);

class const VocabularySearchView({
  super.key,
  required final VocabularyFilter _filter,
  required final ValueChanged<VocabularyFilter> _onFilterChanged,
  required final VoidCallback _onClosed,
  required final Widget _results,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _filter.query);
    final query = useValueListenable(controller).text;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.m, Spacing.m, 0),
            child: SearchBar(
              controller: controller,
              autoFocus: true,
              hintText: context.s.vocabularySearchHint,
              textInputAction: TextInputAction.search,
              onChanged: (query) => _onFilterChanged(_filter.copyWith(query: query)),
              leading: BackButton(onPressed: _onClosed),
              trailing: [
                if (query.isNotEmpty)
                  IconButton(
                    tooltip: context.s.vocabularySearchClearTooltip,
                    onPressed: () {
                      controller.clear();
                      _onFilterChanged(_filter.copyWith(query: ""));
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
            child: Row(
              spacing: Spacing.xs,
              children: [
                FilterChip(
                  showCheckmark: false,
                  avatar: const Icon(Icons.schedule_rounded),
                  label: Text(context.s.vocabularyFilterDueLabel),
                  selected: _filter.isDueOnly,
                  onSelected: (isDueOnly) =>
                      _onFilterChanged(_filter.copyWith(isDueOnly: isDueOnly)),
                ),
                for (final level in VocabularyLevel.values)
                  FilterChip(
                    showCheckmark: false,
                    avatar: Icon(Icons.circle, color: level.toColor(context)),
                    label: Text(level.toLabel(context)),
                    selected: _filter.levels.contains(level),
                    onSelected: (isSelected) => _onFilterChanged(
                      _filter.copyWith(
                        levels: isSelected
                            ? {..._filter.levels, level}
                            : _filter.levels.difference({level}),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [SliverPadding(padding: _resultsPadding, sliver: _results)],
            ),
          ),
        ],
      ),
    );
  }
}

class const VocabularySearchEmpty({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.xxl),
      child: Text(
        context.s.vocabularySearchEmptyMessage,
        textAlign: TextAlign.center,
        style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
      ),
    );
  }
}
