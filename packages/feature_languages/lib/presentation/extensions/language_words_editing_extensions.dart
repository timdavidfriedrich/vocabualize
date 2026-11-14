import 'package:feature_languages/presentation/language_words/language_words_state.dart';
import 'package:shared/domain/entities/language_words_change.dart';

extension LanguageWordsEditingExtensions on LanguageWordsEditing {
  LanguageWordsChange get change => LanguageWordsChange(
    addsAll: false,
    addedTagIds: {
      for (final MapEntry(key: tagId, value: isSelected) in selection.entries)
        if (isSelected == true && initialSelection[tagId] != true) tagId,
    },
    removedTagIds: {
      for (final MapEntry(key: tagId, value: isSelected) in selection.entries)
        if (isSelected == false && initialSelection[tagId] != false) tagId,
    },
    addsUntagged: untagged == true && initialUntagged != true,
    removesUntagged: untagged == false && initialUntagged != false,
  );

  bool get hasChanges {
    final change = this.change;
    return change.addedTagIds.isNotEmpty ||
        change.removedTagIds.isNotEmpty ||
        change.addsUntagged ||
        change.removesUntagged;
  }

  bool isRemoving(String tagId) => selection[tagId] == false && initialSelection[tagId] != false;

  bool get isRemovingUntagged => untagged == false && initialUntagged != false;

  int get importCount => switch (option) {
    LanguageWordsOption.all => coverage.totalCount,
    LanguageWordsOption.choose => preview?.addedCount ?? 0,
    LanguageWordsOption.none => 0,
  };

  int get resultCount =>
      coverage.inLanguageCount + (preview?.addedCount ?? 0) - (preview?.removedCount ?? 0);
}
