import 'package:dart_mappable/dart_mappable.dart';

part 'language_words_change.mapper.dart';

@MappableClass()
class const LanguageWordsChange({
  required final bool addsAll,
  required final Set<String> addedTagIds,
  required final Set<String> removedTagIds,
  required final bool addsUntagged,
  required final bool removesUntagged,
}) with LanguageWordsChangeMappable;

@MappableClass()
class const LanguageWordsPreview({
  required final int addedCount,
  required final int removedCount,
  required final int removedAlsoElsewhereCount,
}) with LanguageWordsPreviewMappable;

const addAllWords = LanguageWordsChange(
  addsAll: true,
  addedTagIds: {},
  removedTagIds: {},
  addsUntagged: false,
  removesUntagged: false,
);
