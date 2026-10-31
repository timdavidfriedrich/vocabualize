import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';

part 'practice_session.mapper.dart';

@MappableEnum()
enum PracticeWords { due, all }

@MappableEnum()
enum PracticeNewWords { none, upToCap, allWaiting }

@MappableClass()
class const PracticeItemKey({
  required final String vocabularyId,
  required final Language language,
}) with PracticeItemKeyMappable;

@MappableClass()
class const CustomPracticeFilter({
  required final Set<Language> languages,
  required final Set<String> tagIds,
  required final PracticeWords words,
  required final PracticeNewWords newWords,
}) with CustomPracticeFilterMappable;

@MappableClass()
class const CustomPracticeSession({
  required final CustomPracticeFilter filter,
  required final List<PracticeItemKey> items,
  required final int doneCount,
  required final DateTime startedAt,
}) with CustomPracticeSessionMappable;

extension CustomPracticeSessionExtensions on CustomPracticeSession {
  int get remainingCount => items.length - doneCount;
}
