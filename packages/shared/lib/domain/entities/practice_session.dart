import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/domain/entities/language.dart';

part 'practice_session.mapper.dart';

@MappableEnum()
enum PracticeWords { due, all }

@MappableClass()
class const PracticeItemKey({
  required final String vocabularyId,
  required final Language language,
}) with PracticeItemKeyMappable;

@MappableClass()
class const CustomPracticeFilter({
  required final Set<Language> languages,
  required final Set<String> tagIds,
}) with CustomPracticeFilterMappable;

@MappableClass()
class const CustomPracticeLanguagePlan({
  required final Language language,
  required final PracticeWords words,
  required final int reviewWordCount,
  required final int newWordCount,
}) with CustomPracticeLanguagePlanMappable;

@MappableClass()
class const CustomPracticePlan({
  required final List<CustomPracticeLanguagePlan> languages,
  required final Set<String> tagIds,
}) with CustomPracticePlanMappable;

@MappableClass()
class const CustomPracticeCounts({
  required final int dueCount,
  required final int startedCount,
  required final int waitingCount,
}) with CustomPracticeCountsMappable;

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

extension CustomPracticePlanExtensions on CustomPracticePlan {
  CustomPracticeFilter get filter => CustomPracticeFilter(
    languages: {for (final plan in languages) plan.language},
    tagIds: tagIds,
  );
}
