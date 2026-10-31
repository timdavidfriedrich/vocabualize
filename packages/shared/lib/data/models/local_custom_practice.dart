import 'package:dart_mappable/dart_mappable.dart';

part 'local_custom_practice.mapper.dart';

@MappableClass()
class const LocalCustomPractice({
  required final List<String> languages,
  required final List<String> tagIds,
  required final String words,
  required final String newWords,
  required final List<LocalCustomPracticeItem> items,
  required final int doneCount,
  required final DateTime startedAt,
}) with LocalCustomPracticeMappable;

@MappableClass()
class const LocalCustomPracticeItem({
  required final String vocabularyId,
  required final String language,
}) with LocalCustomPracticeItemMappable;
