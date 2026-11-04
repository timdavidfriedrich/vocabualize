import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/models/local_custom_practice.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_session.dart';

extension LocalCustomPracticeMappers on LocalCustomPractice {
  CustomPracticeSession toCustomPracticeSession() {
    return CustomPracticeSession(
      filter: CustomPracticeFilter(
        languages: {
          for (final code in languages)
            if (code.toLanguage() case final language when language != Language.unknown) language,
        },
        tagIds: tagIds.toSet(),
      ),
      items: [
        for (final item in items)
          if (item.language.toLanguage() case final language when language != Language.unknown)
            PracticeItemKey(vocabularyId: item.vocabularyId, language: language),
      ],
      doneCount: doneCount,
      startedAt: startedAt.toUtc(),
    );
  }
}

extension CustomPracticeSessionMappers on CustomPracticeSession {
  LocalCustomPractice toLocalCustomPractice() {
    return LocalCustomPractice(
      languages: [for (final language in filter.languages) language.toLanguageCode()],
      tagIds: filter.tagIds.toList(),
      items: [
        for (final item in items)
          LocalCustomPracticeItem(
            vocabularyId: item.vocabularyId,
            language: item.language.toLanguageCode(),
          ),
      ],
      doneCount: doneCount,
      startedAt: startedAt.toUtc(),
    );
  }
}
