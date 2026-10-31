import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/repositories/language_repository.dart';

@injectable
class const ChangeMainLanguageUseCase(
  final LanguageRepository _languageRepository,
) {
  Future<AppResult<()>> call(Language language) async {
    final setupResult = await _languageRepository.readLanguageSetup();
    if (setupResult case Failure(:final error)) return Failure(error);
    final clashing = switch (setupResult) {
      Success(data: final setup?) => [
        for (final learned in setup.active)
          if (learned.language.isSameLanguageAs(language)) learned,
      ],
      Success() || Failure() => const <LearnedLanguage>[],
    };
    for (final learned in clashing) {
      final paused = await _languageRepository.saveLearnedLanguage(
        learned.copyWith(isPaused: true),
      );
      if (paused case Failure(:final error)) return Failure(error);
    }
    return _languageRepository.setMainLanguage(language);
  }
}
