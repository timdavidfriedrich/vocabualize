import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/repositories/translation_fill_repository.dart';

@injectable
class const FillMissingTranslationsUseCase(
  final TranslationFillRepository _translationFillRepository,
) {
  Future<AppResult<()>> call() async {
    while (true) {
      switch (await _translationFillRepository.fillMissingTranslations()) {
        case Failure(:final error):
          return Failure(error);
        case Success(data: 0):
          return const Success(());
        case Success():
          continue;
      }
    }
  }
}
