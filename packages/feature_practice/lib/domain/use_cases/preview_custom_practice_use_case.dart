import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _previewCount = 3;

@injectable
class const PreviewCustomPracticeUseCase(
  final VocabularyRepository _vocabularyRepository,
) {
  Future<AppResult<List<VocabularyImage>>> call({
    required Set<Language> languages,
    required Set<String> tagIds,
  }) async {
    if (languages.isEmpty) return const Success([]);
    final due = await _vocabularyRepository.findDueItems(
      languages: languages,
      dueBy: DateTime.now().toUtc(),
      limit: _previewCount,
      tagIds: tagIds,
    );
    if (due case Failure(:final error)) return Failure(error);
    final items = <PracticeItem>[
      if (due case Success(:final data)) ...data,
    ];
    for (final language in languages) {
      if (items.length >= _previewCount) break;
      final waiting = await _vocabularyRepository.findWaitingItems(
        language: language,
        limit: _previewCount - items.length,
        tagIds: tagIds,
      );
      switch (waiting) {
        case Success(:final data):
          items.addAll(data);
        case Failure(:final error):
          return Failure(error);
      }
    }
    final images = {for (final item in items) item.vocabulary.id: item.vocabulary.image};
    return Success(images.values.take(_previewCount).toList());
  }
}
