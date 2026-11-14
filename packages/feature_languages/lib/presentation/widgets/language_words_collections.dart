import 'package:feature_languages/presentation/extensions/language_words_editing_extensions.dart';
import 'package:feature_languages/presentation/language_words/language_words_bloc.dart';
import 'package:feature_languages/presentation/language_words/language_words_event.dart';
import 'package:feature_languages/presentation/language_words/language_words_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/tag_extensions.dart';
import 'package:shared/presentation/widgets/collection_select_tile.dart';

class const LanguageWordsCollections({
  super.key,
  required final LanguageWordsEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageWordsBloc>();
    final label = _state.language.toShortLabel(context);
    return CollectionSelectGroup(
      children: [
        for (final collection in _state.coverage.collections)
          if (collection.totalCount > 0)
            CollectionSelectTile(
              title: collection.tag.toLabel(),
              image: _state.images[collection.tag.id],
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
          CollectionSelectTile(
            title: context.s.languageWordsUntaggedLabel,
            image: null,
            placeholderIcon: Icons.folder_off_outlined,
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
    if (!_state.isAdding && isRemoving) return context.s.languageWordsRemovedWarning(count, label);
    return context.s.languagesWordCount(count);
  }
}
